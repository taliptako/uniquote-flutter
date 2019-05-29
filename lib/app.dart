import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:uniquote_flutter/screens/auth/auth_check.dart';
import 'package:uniquote_flutter/config/route_generator.dart';

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();
  final _navigatorKey = GlobalKey<NavigatorState>();

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
      navigatorKey: _navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: 'auth_check',
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (_) => AuthCheck());
      },
    );
  }
}
