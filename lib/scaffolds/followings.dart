import 'package:flutter/material.dart';

import 'package:uniquote_flutter/common/common.dart';
import 'package:uniquote_flutter/models/user_store.dart';
import 'package:uniquote_flutter/screens/users/followings_screen.dart';

class Followings extends StatelessWidget {
  final UserStore user;

  const Followings({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${user.name} Followings"),
      ),
      bottomNavigationBar: BottomNavigation(),
      body: FollowingsScreen(user: user),
    );
  }
}
