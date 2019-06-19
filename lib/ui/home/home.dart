import 'package:flutter/material.dart';

import 'package:uniquote_flutter/common/common.dart';
import 'package:uniquote_flutter/ui/home/feed.dart';
import 'package:uniquote_flutter/ui/home/most_liked.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: DrawerWidget(),
        bottomNavigationBar: BottomNavigation(),
        appBar: AppBar(
          title: Text('Home'),
          bottom: TabBar(
            tabs: <Widget>[Tab(text: "Feed"), Tab(text: "Most Liked")],
          ),
        ),
        body: TabBarView(
          children: [Feed(), MostLiked()],
        ),
      ),
    );
  }
}
