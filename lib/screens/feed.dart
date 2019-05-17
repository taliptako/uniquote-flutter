import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:uniquote/stores/feed_store.dart';
import 'package:uniquote/widgets/quote/quote_widget.dart';
import 'package:uniquote/widgets/bottom_loader.dart';

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

    _feedStore.refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (_feedStore.quotes.isEmpty) {
        return Center(child: CircularProgressIndicator());
      } else {
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
              return index + 1 >= _feedStore.quotes.length
                  ? BottomLoader()
                  : QuoteWidget(_feedStore.quotes[index]);
            },
          ),
        );
      }
    });
  }
}
