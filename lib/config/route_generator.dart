import 'package:flutter/material.dart';

import 'package:uniquote_flutter/config/sl.dart';
import 'package:uniquote_flutter/stores/root_store.dart';

import 'package:uniquote_flutter/components/webview_holder.dart';

import 'package:uniquote_flutter/screens/auth/auth_check.dart';

import 'package:uniquote_flutter/scaffolds/register.dart';
import 'package:uniquote_flutter/scaffolds/login.dart';

import 'package:uniquote_flutter/scaffolds/tabs.dart';
import 'package:uniquote_flutter/scaffolds/home.dart';
import 'package:uniquote_flutter/scaffolds/tag.dart';
import 'package:uniquote_flutter/scaffolds/tag_list.dart';
import 'package:uniquote_flutter/scaffolds/users.dart';
import 'package:uniquote_flutter/scaffolds/profile.dart';
import 'package:uniquote_flutter/scaffolds/profile_edit.dart';
import 'package:uniquote_flutter/scaffolds/quote_detail.dart';
import 'package:uniquote_flutter/scaffolds/followers.dart';
import 'package:uniquote_flutter/scaffolds/followings.dart';

import 'package:uniquote_flutter/scaffolds/favorites.dart';
import 'package:uniquote_flutter/scaffolds/about.dart';
import 'package:uniquote_flutter/scaffolds/report.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AuthCheck());

      case 'auth_check':
        return MaterialPageRoute(builder: (_) => AuthCheck());

      case '/register':
        return MaterialPageRoute(builder: (_) => Register());

      case '/login':
        return MaterialPageRoute(builder: (_) => Login());

      case '/tabs':
        return MaterialPageRoute(builder: (_) => Tabs());

      case '0':
        return MaterialPageRoute(builder: (_) => Home());

      case '1':
        return MaterialPageRoute(builder: (_) => Tag());

      case '2':
        return MaterialPageRoute(builder: (_) => Users());

      case '3':
        if (sl<RootStore>().user != null) {
          return MaterialPageRoute(
              builder: (_) => Profile(user: sl<RootStore>().user));
        }
        return MaterialPageRoute(builder: (_) => Profile());

      case '/quote_detail':
        return MaterialPageRoute(
            builder: (_) => QuoteDetail(
                  quote: args,
                ));

      case '/favorites':
        return MaterialPageRoute(builder: (_) => Favorites());

      case '/about':
        return MaterialPageRoute(builder: (_) => About());

      case '/followers':
        return MaterialPageRoute(
            builder: (_) => Followers(
                  user: args,
                ));

      case '/followings':
        return MaterialPageRoute(
            builder: (_) => Followings(
                  user: args,
                ));

      case '/profile':
        return MaterialPageRoute(
            builder: (_) => Profile(
                  user: args,
                ));

      case '/profile_edit':
        return MaterialPageRoute(builder: (_) => ProfileEdit());

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

      case '/report':
        final Report args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => Report(
                  type: args.type,
                  data: args.data,
                ));

      default:
        return MaterialPageRoute(builder: (_) => AuthCheck());
    }
  }
}
