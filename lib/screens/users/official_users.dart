import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:uniquote/components/error_notifier.dart';
import 'package:uniquote/stores/users/official_users_store.dart';
import 'package:uniquote/widgets/bottom_loader.dart';
import 'package:uniquote/widgets/user/user_widget.dart';

class OfficialUsers extends StatefulWidget {
  @override
  _OfficialUsersState createState() => _OfficialUsersState();
}

class _OfficialUsersState extends State<OfficialUsers>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  OfficialUsersStore _officialUsersStore = OfficialUsersStore();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() async {
      final maxScroll = _scrollController.position.maxScrollExtent;
      if (maxScroll == _scrollController.position.pixels) {
        await _officialUsersStore.fetch();
      }
    });

    ErrorNotifier(context).invoke();

    _officialUsersStore.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Observer(builder: (_) {
      if (_officialUsersStore.page == 1 && _officialUsersStore.hasReachedEnd) {
        return Center(
          child: Text('No User'),
        );
      } else if (!_officialUsersStore.hasReachedEnd &&
          _officialUsersStore.users.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (_officialUsersStore.users.isEmpty) {
        return Center(child: CircularProgressIndicator());
      } else {
        return LiquidPullToRefresh(
          showChildOpacityTransition: false,
          scrollController: _scrollController,
          onRefresh: () async {
            await _officialUsersStore.refresh();
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _officialUsersStore.users.length,
            itemBuilder: (context, index) {
              return index + 1 >= _officialUsersStore.users.length &&
                      !_officialUsersStore.hasReachedEnd &&
                      _officialUsersStore.users.length > 5
                  ? Column(
                      children: <Widget>[
                        UserWidget(user: _officialUsersStore.users[index]),
                        BottomLoader()
                      ],
                    )
                  : UserWidget(user: _officialUsersStore.users[index]);
            },
          ),
        );
      }
    });
  }
}
