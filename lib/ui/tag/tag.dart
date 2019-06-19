import 'package:flutter/material.dart';

import 'package:uniquote_flutter/common/common.dart';
import 'package:uniquote_flutter/ui/tag/tag_screen.dart';

class Tag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text("Tags"),
      ),
      bottomNavigationBar: BottomNavigation(),
      body: TagScreen(),
    );
  }
}
