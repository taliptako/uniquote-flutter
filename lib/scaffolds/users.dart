import 'package:flutter/material.dart';

import 'package:uniquote_flutter/common/common.dart';
import 'package:uniquote_flutter/screens/users/official_users.dart';
import 'package:uniquote_flutter/screens/users/normal_users.dart';

class Users extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: DrawerWidget(),
        bottomNavigationBar: BottomNavigation(),
        appBar: AppBar(
          title: Text('Users'),
          bottom: TabBar(
            tabs: <Widget>[Tab(text: "Official"), Tab(text: "Normal")],
          ),
        ),
        body: TabBarView(
          children: [OfficialUsers(), NormalUsers()],
        ),
      ),
    );
  }
}
