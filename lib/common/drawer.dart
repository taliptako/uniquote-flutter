import 'package:flutter/material.dart';

import 'package:uniquote/controllers/auth_controller.dart';

class DrawerWidget extends StatelessWidget {
  AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () async {
              final bool result = await _authController.logout();
              if (result == true) {
                _authController.logoutPush(context);
              }
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
            },
          ),
        ],
      ),
    );
  }
}
