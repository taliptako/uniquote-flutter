import 'package:flutter/material.dart';

import 'package:uniquote_flutter/config/sl.dart';
import 'package:uniquote_flutter/config/config.dart';
import 'package:uniquote_flutter/components/webview_holder.dart';

class AboutScreen extends StatelessWidget {
  final Config _config = sl<Config>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      child: ListView(
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/img/icon-only.png',
              width: MediaQuery.of(context).size.width / 3.1,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/img/text-only.png',
              width: MediaQuery.of(context).size.width / 1.4,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
                "A unique quote database that connects users with each other and allows them to follow topics they're interested in. ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/webview',
                    arguments: WebViewHolder(
                      title: "Privacy Policy",
                      url: _config.privacyUrl,
                    ));
              },
              child: Text(
                'Privacy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    color: Colors.red),
              ),
            ),
          )
        ],
      ),
    );
  }
}
