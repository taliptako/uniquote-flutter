import 'package:flutter/material.dart';

import 'package:uniquote_flutter/config/sl.dart';
import 'package:uniquote_flutter/stores/root_store.dart';
import 'package:uniquote_flutter/models/user_store.dart';
import 'package:uniquote_flutter/common/common.dart';
import 'package:uniquote_flutter/ui/profile/profile_screen.dart';

class Profile extends StatelessWidget {
  final UserStore user;

  Profile({Key key, this.user}) : super(key: key);

  final RootStore _rootStore = sl<RootStore>();

  @override
  Widget build(BuildContext context) {
    if(_rootStore.user.email == user.email) {
      return Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          title: Text("${user.name}"),
        ),
        bottomNavigationBar: BottomNavigation(),
        body: ProfileScreen(user: user),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${user.name}"),
      ),
      bottomNavigationBar: BottomNavigation(),
      body: ProfileScreen(user: user),
    );
  }
}
