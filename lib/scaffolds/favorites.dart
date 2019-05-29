import 'package:flutter/material.dart';

import 'package:uniquote_flutter/common/common.dart';
import 'package:uniquote_flutter/screens/favorites/favorites_screen.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      bottomNavigationBar: BottomNavigation(),
      body: FavoritesScreen(),
    );
  }
}
