import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:uniquote/widgets/bottom_loader.dart';
import 'package:uniquote/widgets/quote/quote_widget.dart';
import 'package:uniquote/stores/favorites_store.dart';

class FavoritesQuotes extends StatelessWidget {
  final FavoritesStore favoritesStore;

  const FavoritesQuotes({Key key, this.favoritesStore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return index + 1 >= favoritesStore.quotes.length &&
                  !favoritesStore.hasReachedEnd &&
              favoritesStore.quotes.length > 5
              ? Column(
                  children: <Widget>[
                    QuoteWidget(favoritesStore.quotes[index]),
                    BottomLoader()
                  ],
                )
              : QuoteWidget(favoritesStore.quotes[index]);
        }, childCount: favoritesStore.quotes.length),
      );
    });
  }
}
