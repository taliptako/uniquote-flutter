import 'package:flutter/material.dart';

import 'package:uniquote_flutter/common/common.dart';
import 'package:uniquote_flutter/ui/report/report_screen.dart';

class Report extends StatelessWidget {
  final String type;
  final data;

  const Report({Key key, this.type, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
      ),
      bottomNavigationBar: BottomNavigation(),
      body: ReportScreen(type: type, data: data),
    );
  }
}
