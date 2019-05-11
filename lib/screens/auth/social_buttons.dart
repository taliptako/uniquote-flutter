import 'package:flutter/material.dart';

import 'package:groovin_material_icons/groovin_material_icons.dart';

import 'package:uniquote/components/progress.dart';
import 'package:uniquote/controllers/auth_controller.dart';

class SocialButtons extends StatelessWidget {
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: InkWell(
            onTap: () async {
              Progress.show(context);
              final bool result = await _authController.googleLogin();
              if (result == true) {
                _authController.successPush(context);
              } else {
                _authController.logoutPush(context);
              }
            },
            borderRadius: BorderRadius.circular(30.0),
            child: Icon(GroovinMaterialIcons.google, color: Colors.deepPurple),
          ),
          height: 56.0,
          width: 56.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 0.5)),
        ),
      ],
    );
  }
}
