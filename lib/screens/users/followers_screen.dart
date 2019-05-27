import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:uniquote/models/user_store.dart';
import 'package:uniquote/components/error_notifier.dart';
import 'package:uniquote/stores/users/followers_store.dart';
import 'package:uniquote/widgets/bottom_loader.dart';
import 'package:uniquote/widgets/user/user_widget.dart';

class FollowersScreen extends StatefulWidget {
  final UserStore user;

  const FollowersScreen({Key key, this.user}) : super(key: key);

  @override
  _FollowersScreenState createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  FollowersStore _followersStore = FollowersStore();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() async {
      final maxScroll = _scrollController.position.maxScrollExtent;
      if (maxScroll == _scrollController.position.pixels) {
        await _followersStore.fetch(widget.user.id);
      }
    });

    ErrorNotifier(context).invoke();

    _followersStore.fetch(widget.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (_followersStore.page == 1 && _followersStore.hasReachedEnd) {
        return Center(
          child: Text('No User'),
        );
      } else if (!_followersStore.hasReachedEnd &&
          _followersStore.users.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return LiquidPullToRefresh(
        showChildOpacityTransition: false,
        scrollController: _scrollController,
        onRefresh: () async {
          await _followersStore.refresh(widget.user.id);
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _followersStore.users.length,
          itemBuilder: (context, index) {
            return index + 1 >= _followersStore.users.length &&
                    !_followersStore.hasReachedEnd &&
                    _followersStore.users.length > 5
                ? Column(
                    children: <Widget>[
                      UserWidget(user: _followersStore.users[index]),
                      BottomLoader()
                    ],
                  )
                : UserWidget(user: _followersStore.users[index]);
          },
        ),
      );
    });
  }
}
