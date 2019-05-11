import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:uniquote/config/route_generator.dart';

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "UniQuote",
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        initialRoute: '/auth_check',
        onGenerateRoute: RouteGenerator.generateRoute);
  }
}
