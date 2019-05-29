import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:uniquote_flutter/components/error_notifier.dart';
import 'package:uniquote_flutter/stores/users/normal_users_store.dart';
import 'package:uniquote_flutter/widgets/bottom_loader.dart';
import 'package:uniquote_flutter/widgets/user/user_widget.dart';

class NormalUsers extends StatefulWidget {
  @override
  _NormalUsersState createState() => _NormalUsersState();
}

class _NormalUsersState extends State<NormalUsers>
    with AutomaticKeepAliveClientMixin {
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

    ErrorNotifier(context).invoke();

    _normalUsersStore.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Observer(builder: (_) {
      if (_normalUsersStore.page == 1 && _normalUsersStore.hasReachedEnd) {
        return Center(
          child: Text('No User'),
        );
      } else if (!_normalUsersStore.hasReachedEnd &&
          _normalUsersStore.users.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

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
            return index + 1 >= _normalUsersStore.users.length &&
                    !_normalUsersStore.hasReachedEnd &&
                    _normalUsersStore.users.length > 5
                ? Column(
                    children: <Widget>[
                      UserWidget(user: _normalUsersStore.users[index]),
                      BottomLoader()
                    ],
                  )
                : UserWidget(user: _normalUsersStore.users[index]);
          },
        ),
      );
    });
  }
}
