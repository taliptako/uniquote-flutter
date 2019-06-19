import 'dart:async';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:sentry/sentry.dart';

import 'package:uniquote_flutter/config/http.dart';
import 'package:uniquote_flutter/config/sl.dart';
import 'package:uniquote_flutter/stores/root_store.dart';
import 'package:uniquote_flutter/config/config.dart';
import 'package:uniquote_flutter/app.dart';

final SentryClient _sentry = new SentryClient(
    dsn: "https://7226c520109440ca970cb517051b4d59@sentry.io/1473034");

void main() {
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Sentry.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  if (isInDebugMode) {
    final config = Config();
    config.debug();
    sl.registerSingleton<Config>(config);
  } else {
    final config = Config();
    config.prod();
    sl.registerSingleton<Config>(config);
  }

  sl.registerSingleton<RootStore>(RootStore());

  // http
  dio.options.baseUrl = sl<Config>().apiUrl;
  dio.options.connectTimeout = 6000; //5s
  dio.options.receiveTimeout = 9000;
  dio.options.responseType = ResponseType.plain;
  dio.interceptors.add(InterceptorsWrapper(onError: (DioError e) {
    sl<RootStore>().error = e;
  }));
  // http

  runZoned<Future<Null>>(() async {
    runApp(new MyApp());
  }, onError: (error, stackTrace) async {
    await _reportError(error, stackTrace);
  });
}

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');

  if (isInDebugMode) {
    print(stackTrace);
    print('In dev mode. Not sending report to Sentry.io.');
    return;
  }

  print('Reporting to Sentry.io...');

  final SentryResponse response = await _sentry.captureException(
    exception: error,
    stackTrace: stackTrace,
  );

  if (response.isSuccessful) {
    print('Success! Event ID: ${response.eventId}');
  } else {
    print('Failed to report to Sentry.io: ${response.error}');
  }
}
