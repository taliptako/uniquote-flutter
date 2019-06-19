import 'package:flutter/material.dart';

class RegisterTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          'assets/img/text-only.png',
          width: MediaQuery.of(context).size.width / 1.2,
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
