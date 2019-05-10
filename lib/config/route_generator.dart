import 'package:flutter/material.dart';

import 'package:uniquote/scaffolds/home.dart';
import 'package:uniquote/scaffolds/tag.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/0':
        return MaterialPageRoute(builder: (_) => Home());

      case '/1':
        return MaterialPageRoute(builder: (_) => Tag());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
