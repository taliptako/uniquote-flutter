import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:uniquote_flutter/components/navigator_page.dart';
import 'package:uniquote_flutter/config/sl.dart';
import 'package:uniquote_flutter/stores/root_store.dart';

class Tabs extends StatelessWidget {
  final RootStore _rootStore = sl<RootStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => IndexedStack(
              index: _rootStore.bottomNav,
              children: <Widget>[
                NavigatorPage(route: '0'),
                NavigatorPage(route: '1'),
                NavigatorPage(route: '2'),
                NavigatorPage(route: '3'),
              ],
            ),
      ),
    );
  }
}
