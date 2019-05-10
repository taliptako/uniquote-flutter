import 'package:flutter/material.dart';

import 'package:share/share.dart';

import 'package:uniquote/models/quote_store.dart';

class BottomModal extends StatelessWidget {
  BottomModal(this.quote);

  final QuoteStore quote;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      height: 120,
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/report',
                    arguments: Container());
              },
              leading: Icon(Icons.report),
              title: Text('Report'),
            ),
            ListTile(
              onTap: () {
                Share.share("${quote.quote}  ${quote.user.name}");
              },
              leading: Icon(Icons.share),
              title: Text('Share'),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10),
            topRight: const Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
