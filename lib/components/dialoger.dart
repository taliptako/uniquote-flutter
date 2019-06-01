import 'package:flutter/material.dart';

import 'package:edge_alert/edge_alert.dart';
import 'package:achievement_view/achievement_view.dart';

class Dialoger {
  final BuildContext context;

  Dialoger(this.context);

  void added(String title, String message) {
    AchievementView(
      context,
      title: title,
      subTitle: message,
      icon: Icon(Icons.thumb_up, color: Colors.white),
      color: Colors.deepPurple,
      alignment: Alignment.center,
      duration: Duration(seconds: 3),
      isCircle: false,
    )..show();
  }

  void redAlert(String title, String message) {
    EdgeAlert.show(context,
        icon: Icons.error,
        duration: 2,
        title: title,
        backgroundColor: Colors.red,
        description: message,
        gravity: EdgeAlert.BOTTOM);
  }
}
