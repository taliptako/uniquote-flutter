import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:uniquote_flutter/models/user_store.dart';
import 'package:uniquote_flutter/components/error_notifier.dart';
import 'package:uniquote_flutter/stores/users/followings_store.dart';
import 'package:uniquote_flutter/widgets/bottom_loader.dart';
import 'package:uniquote_flutter/widgets/user/user_widget.dart';

class FollowingsScreen extends StatefulWidget {
  final UserStore user;

  const FollowingsScreen({Key key, this.user}) : super(key: key);

  @override
  _FollowingsScreenState createState() => _FollowingsScreenState();
}

class _FollowingsScreenState extends State<FollowingsScreen> {
  FollowingsStore _followingsStore = FollowingsStore();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() async {
      final maxScroll = _scrollController.position.maxScrollExtent;
      if (maxScroll == _scrollController.position.pixels) {
        await _followingsStore.fetch(widget.user.id);
      }
    });

    ErrorNotifier(context).invoke();

    _followingsStore.fetch(widget.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (_followingsStore.page == 1 && _followingsStore.hasReachedEnd) {
        return Center(
          child: Text('No Followings'),
        );
      } else if (!_followingsStore.hasReachedEnd &&
          _followingsStore.users.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return LiquidPullToRefresh(
        showChildOpacityTransition: false,
        scrollController: _scrollController,
        onRefresh: () async {
          await _followingsStore.refresh(widget.user.id);
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _followingsStore.users.length,
          itemBuilder: (context, index) {
            return index + 1 >= _followingsStore.users.length &&
                    !_followingsStore.hasReachedEnd &&
                    _followingsStore.users.length > 5
                ? Column(
                    children: <Widget>[
                      UserWidget(user: _followingsStore.users[index]),
                      BottomLoader()
                    ],
                  )
                : UserWidget(user: _followingsStore.users[index]);
          },
        ),
      );
    });
  }
}
