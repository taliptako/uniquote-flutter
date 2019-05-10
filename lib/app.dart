import 'package:flutter/material.dart';

import 'package:uniquote/scaffolds/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "UniQuote",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Home(),
    );
  }
}
