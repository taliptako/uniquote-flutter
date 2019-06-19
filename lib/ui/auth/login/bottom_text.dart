import 'package:flutter/material.dart';

class BottomText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/register');
      },
      child: Align(
        child: RichText(
          text: TextSpan(
              text: "You Don't have an account? ",
              style: TextStyle(fontSize: 13.0, color: Colors.grey),
              children: <TextSpan>[
                TextSpan(
                    text: ' SIGN UP',
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
