import 'package:flutter/material.dart';

class RegisterBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/login');
      },
      child: Align(
        child: RichText(
          text: TextSpan(
              text: "You already have an account ? ",
              style: TextStyle(fontSize: 13.0, color: Colors.grey),
              children: <TextSpan>[
                TextSpan(
                    text: ' LOGIN',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.black)),
              ]),
        ),
      ),
    );
  }
}
