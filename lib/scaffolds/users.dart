import 'package:flutter/material.dart';

import 'package:uniquote/common/common.dart';
import 'package:uniquote/screens/users/official_users.dart';
import 'package:uniquote/screens/users/normal_users.dart';

class Users extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: DrawerWidget(),
        bottomNavigationBar: BottomNavigation(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
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
