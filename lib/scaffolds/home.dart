import 'package:flutter/material.dart';

import 'package:uniquote/common/common.dart';
import 'package:uniquote/screens/feed.dart';
import 'package:uniquote/screens/most_liked.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: BottomNavigation(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Home'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Feed",
              ),
              Tab(text: "Most Liked")
            ],
          ),
        ),
        body: TabBarView(
          children: [Feed(), MostLiked()],
        ),
      ),
    );
  }
}
