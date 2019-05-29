import 'package:flutter/material.dart';

import 'package:uniquote_flutter/models/user_store.dart';
import 'package:uniquote_flutter/common/common.dart';
import 'package:uniquote_flutter/screens/profile/profile_screen.dart';

class Profile extends StatelessWidget {
  final UserStore user;

  const Profile({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${user.name}"),
      ),
      bottomNavigationBar: BottomNavigation(),
      body: ProfileScreen(user: user),
    );
  }
}
