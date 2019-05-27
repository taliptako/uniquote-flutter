import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:uniquote/components/error_notifier.dart';
import 'package:uniquote/stores/most_liked_store.dart';
import 'package:uniquote/widgets/quote/quote_widget.dart';
import 'package:uniquote/widgets/bottom_loader.dart';

class MostLiked extends StatefulWidget {
  @override
  _MostLikedState createState() => _MostLikedState();
}

class _MostLikedState extends State<MostLiked>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final MostLikedStore _mostLikedStore = MostLikedStore();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() async {
      final maxScroll = _scrollController.position.maxScrollExtent;
      if (maxScroll == _scrollController.position.pixels) {
        await _mostLikedStore.fetch();
      }
    });

    ErrorNotifier(context).invoke();

    _mostLikedStore.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Observer(builder: (_) {
      if (_mostLikedStore.page == 1 && _mostLikedStore.hasReachedEnd) {
        return Center(
          child: Text('No Quotes'),
        );
      } else if (!_mostLikedStore.hasReachedEnd &&
          _mostLikedStore.quotes.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return LiquidPullToRefresh(
        showChildOpacityTransition: false,
        scrollController: _scrollController,
        onRefresh: () async {
          await _mostLikedStore.refresh();
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _mostLikedStore.quotes.length,
          itemBuilder: (context, index) {
            return index + 1 >= _mostLikedStore.quotes.length &&
                    !_mostLikedStore.hasReachedEnd &&
                    _mostLikedStore.quotes.length > 5
                ? Column(
                    children: <Widget>[
                      QuoteWidget(_mostLikedStore.quotes[index]),
                      BottomLoader()
                    ],
                  )
                : QuoteWidget(_mostLikedStore.quotes[index]);
          },
        ),
      );
    });
  }
}
