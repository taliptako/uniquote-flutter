import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:uniquote_flutter/models/quote_store.dart';
import 'package:uniquote_flutter/widgets/quote/quote_widget.dart';
import 'package:uniquote_flutter/widgets/comment/comment_widget.dart';
import 'package:uniquote_flutter/stores/quote_detail_store.dart';

class QuoteDetailScreen extends StatefulWidget {
  final QuoteStore quote;

  const QuoteDetailScreen({Key key, this.quote}) : super(key: key);

  @override
  _QuoteDetailScreenState createState() => _QuoteDetailScreenState();
}

class _QuoteDetailScreenState extends State<QuoteDetailScreen> {
  final QuoteDetailStore _quoteDetailStore = QuoteDetailStore();

  @override
  void initState() {
    _quoteDetailStore.fetchComments(widget.quote.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
            child: QuoteWidget(
          widget.quote,
          current: true,
        )),
        SliverToBoxAdapter(
            child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.grey[100],
          child: Observer(
              builder: (_) => Text(
                  '${_quoteDetailStore.comments.length} Comments',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
        )),
        Observer(builder: (_) {
          if (_quoteDetailStore.comments.isEmpty &&
              _quoteDetailStore.hasReachedEnd) {
            return SliverFillRemaining(
              child: Container(
                alignment: Alignment.center,
                color: Colors.grey[100],
                child: Text('No Comments',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ),
            );
          } else if (_quoteDetailStore.comments.isEmpty) {
            return SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                  color: Colors.grey[100],
                  child: CommentWidget(
                      comment: _quoteDetailStore.comments[index]));
            }, childCount: _quoteDetailStore.comments.length),
          );
        }),
      ],
    );
  }
}
