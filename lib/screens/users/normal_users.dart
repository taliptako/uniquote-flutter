import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:uniquote/stores/users/normal_users_store.dart';
import 'package:uniquote/widgets/bottom_loader.dart';
import 'package:uniquote/widgets/user/user_widget.dart';

class NormalUsers extends StatefulWidget {
  @override
  _NormalUsersState createState() => _NormalUsersState();
}

class _NormalUsersState extends State<NormalUsers> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  NormalUsersStore _normalUsersStore = NormalUsersStore();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() async {
      final maxScroll = _scrollController.position.maxScrollExtent;
      if (maxScroll == _scrollController.position.pixels) {
        await _normalUsersStore.fetch();
      }
    });

    _normalUsersStore.refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (_normalUsersStore.users.isEmpty) {
        return Center(child: CircularProgressIndicator());
      } else {
        return LiquidPullToRefresh(
          showChildOpacityTransition: false,
          scrollController: _scrollController,
          onRefresh: () async {
            await _normalUsersStore.refresh();
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _normalUsersStore.users.length,
            itemBuilder: (context, index) {
              return index + 1 >= _normalUsersStore.users.length
                  ? BottomLoader()
                  : UserWidget(user: _normalUsersStore.users[index]);
            },
          ),
        );
      }
    });
  }
}
