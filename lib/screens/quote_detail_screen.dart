import 'package:flutter/material.dart';

import 'package:uniquote_flutter/models/quote_store.dart';
import 'package:uniquote_flutter/widgets/quote/quote_widget.dart';
import 'package:uniquote_flutter/widgets/comment/comment_widget.dart';

class QuoteDetailScreen extends StatelessWidget {
  final QuoteStore quote;

  const QuoteDetailScreen({Key key, this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(child: QuoteWidget(quote)),
        SliverToBoxAdapter(
            child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.grey[100],
          child: Text('10 Comments',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        )),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(color: Colors.grey[100], child: CommentWidget());
          }, childCount: 10),
        )
      ],
    );
  }
}
