import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:achievement_view/achievement_view.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'package:uniquote/screens/auth/auth_check.dart';
import 'package:uniquote/config/route_generator.dart';
import 'package:uniquote/scaffolds/home.dart';
import 'package:uniquote/scaffolds/users.dart';
import 'package:uniquote/scaffolds/tag.dart';

class NavigatorPage extends StatefulWidget {
  final String route;

  const NavigatorPage({Key key, this.route}) : super(key: key);

  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await _navigatorKey.currentState.maybePop(),
      child: Navigator(
        key: _navigatorKey,
        initialRoute: "${widget.route}",
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
