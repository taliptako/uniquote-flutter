import 'package:flutter/material.dart';

import 'package:mobx/mobx.dart';
import 'package:edge_alert/edge_alert.dart';

import 'package:uniquote/stores/root_store.dart';
import 'package:uniquote/config/sl.dart';

class ErrorNotifier {
  final RootStore _rootStore = sl<RootStore>();

  final BuildContext context;

  ErrorNotifier(this.context);

  void invoke() {
    reaction((_) => _rootStore.error, (msg) {
      check();
    });
  }

  void check() {
    if(_rootStore.error.response.statusCode == 429) {
      tooMany();
    }else {
      error();
    }

  }

  void tooMany() {
    EdgeAlert.show(context,
        icon: Icons.report_problem,
        duration: 3,
        title: 'Too Many Request',
        backgroundColor: Colors.amber,
        description: _rootStore.error.message,
        gravity: EdgeAlert.BOTTOM);
  }

  void error() {
    EdgeAlert.show(context,
        icon: Icons.error,
        duration: 3,
        title: 'Error occurred',
        backgroundColor: Colors.red,
        description: _rootStore.error.message,
        gravity: EdgeAlert.BOTTOM);
  }
}
