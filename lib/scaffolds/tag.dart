import 'package:flutter/material.dart';

import 'package:uniquote/common/common.dart';
import 'package:uniquote/screens/tag/tag_screen.dart';

class Tag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tags"),
      ),
      bottomNavigationBar: BottomNavigation(),
      body: TagScreen(),
    );
  }
}
