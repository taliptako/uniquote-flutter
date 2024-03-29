import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:uniquote_flutter/components/error_notifier.dart';
import 'package:uniquote_flutter/stores/tag/tag_recent_store.dart';
import 'package:uniquote_flutter/models/tag_model.dart';
import 'package:uniquote_flutter/widgets/quote/quote_widget.dart';
import 'package:uniquote_flutter/widgets/bottom_loader.dart';

class TagRecent extends StatefulWidget {
  final Tag tag;

  const TagRecent({Key key, this.tag}) : super(key: key);

  @override
  _TagRecentState createState() => _TagRecentState();
}

class _TagRecentState extends State<TagRecent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final TagRecentStore _tagRecentStore = TagRecentStore();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() async {
      final maxScroll = _scrollController.position.maxScrollExtent;
      if (maxScroll == _scrollController.position.pixels) {
        await _tagRecentStore.fetch(widget.tag.id);
      }
    });

    ErrorNotifier(context).invoke();

    _tagRecentStore.fetch(widget.tag.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Observer(builder: (_) {
      if (_tagRecentStore.page == 1 && _tagRecentStore.hasReachedEnd) {
        return Center(
          child: Text('No Quotes'),
        );
      } else if (!_tagRecentStore.hasReachedEnd &&
          _tagRecentStore.quotes.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return LiquidPullToRefresh(
        showChildOpacityTransition: false,
        scrollController: _scrollController,
        onRefresh: () async {
          await _tagRecentStore.refresh(widget.tag.id);
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _tagRecentStore.quotes.length,
          itemBuilder: (context, index) {
            return index + 1 >= _tagRecentStore.quotes.length &&
                    !_tagRecentStore.hasReachedEnd &&
                    _tagRecentStore.quotes.length > 5
                ? Column(
                    children: <Widget>[
                      QuoteWidget(_tagRecentStore.quotes[index]),
                      BottomLoader()
                    ],
                  )
                : QuoteWidget(_tagRecentStore.quotes[index]);
          },
        ),
      );
    });
  }
}
