import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:uniquote_flutter/components/error_notifier.dart';
import 'package:uniquote_flutter/stores/feed_store.dart';
import 'package:uniquote_flutter/widgets/quote/quote_widget.dart';
import 'package:uniquote_flutter/widgets/bottom_loader.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final FeedStore _feedStore = FeedStore();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() async {
      final maxScroll = _scrollController.position.maxScrollExtent;
      if (maxScroll == _scrollController.position.pixels) {
        await _feedStore.fetch();
      }
    });

    ErrorNotifier(context).invoke();

    _feedStore.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Observer(builder: (_) {

      if (_feedStore.page == 1 && _feedStore.hasReachedEnd) {
        return Center(
          child: Text('No Quotes'),
        );
      } else if (!_feedStore.hasReachedEnd &&
          _feedStore.quotes.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return LiquidPullToRefresh(
        showChildOpacityTransition: false,
        scrollController: _scrollController,
        onRefresh: () async {
          await _feedStore.refresh();
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _feedStore.quotes.length,
          itemBuilder: (context, index) {
            return index + 1 >= _feedStore.quotes.length &&
                    !_feedStore.hasReachedEnd &&
                    _feedStore.quotes.length > 5
                ? Column(
                    children: <Widget>[
                      QuoteWidget(_feedStore.quotes[index]),
                      BottomLoader()
                    ],
                  )
                : QuoteWidget(_feedStore.quotes[index]);
          },
        ),
      );
    });
  }
}
