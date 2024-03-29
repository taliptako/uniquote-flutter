import 'package:flutter/material.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:uniquote_flutter/config/sl.dart';
import 'package:uniquote_flutter/stores/root_store.dart';

class BottomNavigation extends StatelessWidget {
  final RootStore rootStore = sl<RootStore>();

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      selectedIndex: rootStore.bottomNav,
      onItemSelected: (index) {
        rootStore.changeBottomNav(index);
      },
      items: [
        BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.deepPurple),
        BottomNavyBarItem(
            icon: Icon(Icons.call_to_action),
            title: Text('Tags'),
            activeColor: Colors.deepPurple),
        BottomNavyBarItem(
            icon: Icon(Icons.people),
            title: Text('Users'),
            activeColor: Colors.deepPurple),
        BottomNavyBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
          activeColor: Colors.deepPurple,
        ),
      ],
    );
  }
}
