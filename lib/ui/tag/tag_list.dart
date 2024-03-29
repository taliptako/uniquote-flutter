import 'package:flutter/material.dart';

import 'package:uniquote_flutter/models/tag_model.dart';
import 'package:uniquote_flutter/common/common.dart';
import 'package:uniquote_flutter/ui/tag/tag_recent.dart';
import 'package:uniquote_flutter/ui/tag/tag_mostliked.dart';

class TagList extends StatelessWidget {
  final Tag tag;

  const TagList({Key key, this.tag}) : super(key: key);

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
          title: Text('${tag.name} Quotes'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Recent",
              ),
              Tab(text: "Most Liked")
            ],
          ),
        ),
        body: TabBarView(
          children: [TagRecent(tag: tag), TagMostLiked(tag: tag)],
        ),
      ),
    );
  }
}
