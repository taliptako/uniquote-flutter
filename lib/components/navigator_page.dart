import 'package:flutter/material.dart';

import 'package:uniquote/config/route_generator.dart';

class NavigatorPage extends StatelessWidget {
  final String route;

  const NavigatorPage({Key key, this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
        initialRoute: route, onGenerateRoute: RouteGenerator.generateRoute);
  }
}
