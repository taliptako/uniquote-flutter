import 'package:flutter/material.dart';

import 'package:uniquote/controllers/auth_controller.dart';

class AuthCheck extends StatefulWidget {
  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final AuthController _authController = AuthController();

  Future check() async {
    if(await _authController.check()) {
      _authController.successPush(context);
    } else {
      await _authController.logoutPush(context);
    }
  }

  @override
  void initState() {
    check();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ));
  }
}
