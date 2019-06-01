import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:uniquote_flutter/config/route_generator.dart';

class NavigatorPage extends StatefulWidget {
  final String route;

  const NavigatorPage({Key key, this.route}) : super(key: key);

  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  final FirebaseAnalytics analytics = FirebaseAnalytics();
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await _navigatorKey.currentState.maybePop(),
      child: Navigator(
        observers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        key: _navigatorKey,
        initialRoute: "${widget.route}",
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
