import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          'assets/img/icon-only.png',
          width: 130,
        ),
        SizedBox(
          height: 7,
        ),
        Image.asset(
          'assets/img/text-only.png',
          width: 200,
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
