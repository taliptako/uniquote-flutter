import 'package:flutter/material.dart';

import 'package:uniquote_flutter/ui/profile/profile_edit_screen.dart';

class ProfileEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Your Profile"),
      ),
      body: ProfileEditScreen(),
    );
  }
}
