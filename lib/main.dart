import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

import 'package:uniquote/config/http.dart';
import 'package:uniquote/config/sl.dart';
import 'package:uniquote/stores/root_store.dart';
import 'package:uniquote/config/config.dart';
import 'package:uniquote/app.dart';

void main() {
  if (kReleaseMode && 1 == 2) {
    final config = Config();
    config.prod();
    sl.registerSingleton<Config>(config);
  } else {
    final config = Config();
    config.debug();
    sl.registerSingleton<Config>(config);
  }

  sl.registerSingleton<RootStore>(RootStore());

  // http
  dio.options.baseUrl = sl<Config>().apiUrl;
  dio.options.connectTimeout = 6000; //5s
  dio.options.receiveTimeout = 9000;
  dio.options.responseType = ResponseType.plain;
  dio.interceptors.add(InterceptorsWrapper(onError: (DioError e) {
    // Do something with response error
  }));
  // http

  runApp(MyApp());
}
