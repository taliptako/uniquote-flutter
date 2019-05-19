import 'package:flutter/material.dart';

import 'package:uniquote/scaffolds/home.dart';
import 'package:uniquote/scaffolds/tag.dart';
import 'package:uniquote/screens/auth/auth_check.dart';
import 'package:uniquote/scaffolds/register.dart';
import 'package:uniquote/scaffolds/login.dart';
import 'package:uniquote/scaffolds/tag_list.dart';
import 'package:uniquote/scaffolds/favorites.dart';
import 'package:uniquote/scaffolds/users.dart';
import 'package:uniquote/scaffolds/tabs.dart';
import 'package:uniquote/scaffolds/about.dart';
import 'package:uniquote/components/webview_holder.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/auth_check':
        return MaterialPageRoute(builder: (_) => AuthCheck());

      case '/register':
        return MaterialPageRoute(builder: (_) => Register());

      case '/login':
        return MaterialPageRoute(builder: (_) => Login());

      case '/tabs':
        return MaterialPageRoute(builder: (_) => Tabs());

      case '/0':
        return MaterialPageRoute(builder: (_) => Home());

      case '/1':
        return MaterialPageRoute(builder: (_) => Tag());

      case '/2':
        return MaterialPageRoute(builder: (_) => Users());

      case '/favorites':
        return MaterialPageRoute(builder: (_) => Favorites());

      case '/about':
        return MaterialPageRoute(builder: (_) => About());

      case '/webview':
        final WebViewHolder args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => WebViewHolder(
                  url: args.url,
                  title: args.title,
                ));

      case '/tag_list':
        return MaterialPageRoute(
            builder: (_) => TagList(
                  tag: args,
                ));

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
