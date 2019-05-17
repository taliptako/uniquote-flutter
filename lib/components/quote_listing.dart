import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:uniquote/models/tag_model.dart';
import 'package:uniquote/widgets/bottom_loader.dart';
import 'package:uniquote/widgets/quote/quote_widget.dart';

class QuoteListing extends StatefulWidget {
  final dynamic store;
  final Tag tag;

  QuoteListing({Key key, this.store, this.tag}) : super(key: key);

  @override
  _QuoteListingState createState() => _QuoteListingState();
}

class _QuoteListingState extends State<QuoteListing> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() async {
      final maxScroll = _scrollController.position.maxScrollExtent;
      if (maxScroll == _scrollController.position.pixels) {
        fetch(widget.tag);
      }
    });

    fetch(widget.tag);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (widget.store.quotes.isEmpty) {
        return Center(child: CircularProgressIndicator());
      } else {
        return LiquidPullToRefresh(
          showChildOpacityTransition: false,
          scrollController: _scrollController,
          onRefresh: () async {
            await refresh(widget.tag);
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.store.quotes.length,
            itemBuilder: (context, index) {
              return index + 1 >= widget.store.quotes.length
                  ? BottomLoader()
                  : QuoteWidget(widget.store.quotes[index]);
            },
          ),
        );
      }
    });
  }

  Future<void> refresh(Tag tag) async {
    widget.tag != null
        ? await widget.store.fetch(widget.tag.id)
        : await widget.store.fetch();
  }

  Future<void> fetch(Tag tag) async {
    widget.tag != null
        ? await widget.store.fetch(widget.tag.id)
        : await widget.store.fetch();
  }
}
