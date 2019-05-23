import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:uniquote/stores/tag/tag_mostliked_store.dart';
import 'package:uniquote/models/tag_model.dart';
import 'package:uniquote/widgets/quote/quote_widget.dart';
import 'package:uniquote/widgets/bottom_loader.dart';

class TagMostLiked extends StatefulWidget {
  final Tag tag;

  const TagMostLiked({Key key, this.tag}) : super(key: key);

  @override
  _TagMostLiked createState() => _TagMostLiked();
}

class _TagMostLiked extends State<TagMostLiked>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final TagMostLikedStore _tagMostLikedStore = TagMostLikedStore();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() async {
      final maxScroll = _scrollController.position.maxScrollExtent;
      if (maxScroll == _scrollController.position.pixels) {
        await _tagMostLikedStore.fetch(widget.tag.id);
      }
    });

    _tagMostLikedStore.refresh(widget.tag.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Observer(builder: (_) {
      if (_tagMostLikedStore.page == 1 && _tagMostLikedStore.hasReachedEnd) {
        return Center(
          child: Text('No Quotes'),
        );
      } else if (!_tagMostLikedStore.hasReachedEnd &&
          _tagMostLikedStore.quotes.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return LiquidPullToRefresh(
        showChildOpacityTransition: false,
        scrollController: _scrollController,
        onRefresh: () async {
          await _tagMostLikedStore.refresh(widget.tag.id);
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _tagMostLikedStore.quotes.length,
          itemBuilder: (context, index) {
            return index + 1 >= _tagMostLikedStore.quotes.length &&
                    !_tagMostLikedStore.hasReachedEnd &&
                    _tagMostLikedStore.quotes.length > 5
                ? Column(
                    children: <Widget>[
                      QuoteWidget(_tagMostLikedStore.quotes[index]),
                      BottomLoader()
                    ],
                  )
                : QuoteWidget(_tagMostLikedStore.quotes[index]);
          },
        ),
      );
    });
  }
}
