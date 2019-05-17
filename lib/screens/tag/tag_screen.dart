import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:uniquote/stores/tag/tag_store.dart';
import 'package:uniquote/widgets/tag_widget.dart';

class TagScreen extends StatefulWidget {
  @override
  _TagScreenState createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  final TagStore _tagStore = TagStore();

  @override
  void initState() {
    _tagStore.fetchFollowed();
    _tagStore.fetchUnFollowed();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Text(
                'Followed Tags',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return TagWidget(
                  tagStore: _tagStore,
                  index: index,
                  tag: _tagStore.followedTags[index],
                  text: 'UnFollow',
                );
              },
              childCount: _tagStore.followedTags.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Text(
                'UnFollowed Tags',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return TagWidget(
                  tagStore: _tagStore,
                  index: index,
                  tag: _tagStore.unFollowedTags[index],
                  text: 'Follow',
                );
              },
              childCount: _tagStore.unFollowedTags.length,
            ),
          ),
        ],
      );
    });
  }
}
