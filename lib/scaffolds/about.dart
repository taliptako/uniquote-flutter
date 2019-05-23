import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'package:uniquote/common/common.dart';
import 'package:uniquote/screens/about_screen.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  void initState() {
    BackButtonInterceptor.add(myInterceptor);
    super.initState();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    if (Navigator.canPop(context)) {
      Navigator.maybePop(context);
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    }
    return true;
  }

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
