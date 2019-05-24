import 'package:flutter/material.dart';

import 'package:achievement_view/achievement_view.dart';
import 'package:edge_alert/edge_alert.dart';

import 'package:uniquote/data/report_api.dart';

class ReportScreen extends StatefulWidget {
  final String type;
  final data;

  const ReportScreen({Key key, this.type, this.data}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  ReportApi _reportApi = ReportApi();
  final _reportForm = GlobalKey<FormState>();

  String dropdownValue = '0';

  String description;

  final items = {'0': 'Inappropriate Content', '1': 'Wrong Content'};

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '${widget.type.toUpperCase()} :',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                        widget.type == "quote"
                            ? widget.data.quote
                            : widget.data.comment,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                )
              ],
            ),
            Container(margin: EdgeInsets.only(top: 25), child: buildForm())
          ],
        ));
  }

  Form buildForm() {
    return Form(
      key: _reportForm,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text('Whats wrong with this ${widget.type.toUpperCase()}',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w600)),
          ),
          DropdownButton(
              isExpanded: true,
              value: dropdownValue,
              onChanged: (newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: items.entries
                  .map<DropdownMenuItem<String>>(
                      (MapEntry<String, String> e) => DropdownMenuItem<String>(
                            value: e.key,
                            child: Text(e.value),
                          ))
                  .toList()),
          TextFormField(
            onSaved: (descInput) => description = descInput,
            maxLines: 5,
            validator: (descInput) {
              if (descInput.isEmpty) {
                return 'Please enter an description';
              }
            },
            decoration: InputDecoration(labelText: 'Description'),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width / 3,
            child: RaisedButton(
              color: Colors.deepPurple,
              onPressed: () async {
                if (_reportForm.currentState.validate()) {
                  //Only gets here if the fields pass
                  _reportForm.currentState.save();
                  final bool result = await _reportApi.reportQuote(
                      widget.data.id, int.parse(dropdownValue), description);
                  if (result) {
                    AchievementView(
                      context,
                      title: "Thanks for your contribution",
                      subTitle: "Your report has been submitted successfully",
                      //onTab: _onTabAchievement,
                      icon: Icon(Icons.thumb_up, color: Colors.white),
                      color: Colors.deepPurple,
                      alignment: Alignment.center,
                      duration: Duration(seconds: 4),
                      isCircle: false,
                    )..show();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    EdgeAlert.show(context,
                        icon: Icons.error,
                        duration: 3,
                        title: 'Error',
                        backgroundColor: Colors.red,
                        description: "You Already reported this Quote",
                        gravity: EdgeAlert.BOTTOM);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                }
              },
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
