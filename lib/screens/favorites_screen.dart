import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:uniquote/components/error_notifier.dart';
import 'package:uniquote/stores/favorites_store.dart';
import 'package:uniquote/widgets/quote/quote_widget.dart';
import 'package:uniquote/widgets/bottom_loader.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  FavoritesStore _favoritesStore = FavoritesStore();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() async {
      final maxScroll = _scrollController.position.maxScrollExtent;
      if (maxScroll == _scrollController.position.pixels) {
        await _favoritesStore.fetch();
      }
    });
    _favoritesStore.refresh();

    ErrorNotifier(context).invoke();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Observer(builder: (_) {
        if (_favoritesStore.page == 1 && _favoritesStore.hasReachedEnd) {
          return Center(
            child: Text('No Quotes'),
          );
        } else if (!_favoritesStore.hasReachedEnd &&
            _favoritesStore.quotes.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return LiquidPullToRefresh(
          showChildOpacityTransition: false,
          scrollController: _scrollController,
          onRefresh: () async {
            await _favoritesStore.refresh();
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _favoritesStore.quotes.length,
            itemBuilder: (context, index) {
              return index + 1 >= _favoritesStore.quotes.length &&
                      !_favoritesStore.hasReachedEnd &&
                      _favoritesStore.quotes.length > 5
                  ? Column(
                      children: <Widget>[
                        QuoteWidget(_favoritesStore.quotes[index]),
                        BottomLoader()
                      ],
                    )
                  : QuoteWidget(_favoritesStore.quotes[index]);
            },
          ),
        );
      });
    });
  }
}
