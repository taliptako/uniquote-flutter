import 'package:flutter/material.dart';

import 'package:uniquote_flutter/widgets/quote/profile_row.dart';
import 'package:uniquote_flutter/models/quote_store.dart';
import 'package:uniquote_flutter/widgets/quote/interactions_row.dart';

class QuoteWidget extends StatelessWidget {
  QuoteWidget(this.quote, {this.current});

  final bool current;
  final QuoteStore quote;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.deepPurple, width: 4))),
      child: Card(
        margin: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/profile',
                      arguments: quote.user);
                },
                child: ProfileRow(quote)),
            _textRow(context),
            Divider(height: 3),
            InteractionRow(quote)
          ],
        ),
      ),
    );
  }

  GestureDetector _textRow(context) {
    return GestureDetector(
      onTap: () {
        if (current == null) {
          Navigator.pushNamed(context, '/quote_detail', arguments: quote);
        }
      },
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(7),
              child: Text(
                quote.quote,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
