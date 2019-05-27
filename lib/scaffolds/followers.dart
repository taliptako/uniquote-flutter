import 'package:flutter/material.dart';

import 'package:uniquote/common/common.dart';
import 'package:uniquote/models/user_store.dart';
import 'package:uniquote/screens/users/followers_screen.dart';

class Followers extends StatelessWidget {
  final UserStore user;

  const Followers({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${user.name} Followers"),
      ),
      bottomNavigationBar: BottomNavigation(),
      body: FollowersScreen(user: user),
    );
  }
}
