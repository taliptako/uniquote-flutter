import 'package:flutter/material.dart';

import 'package:uniquote/common/common.dart';
import 'package:uniquote/screens/about_screen.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      bottomNavigationBar: BottomNavigation(),
      body: AboutScreen(),
    );
  }
}
