import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:uniquote/stores/favorites_store.dart';
import 'package:uniquote/widgets/quote/quote_widget.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  FavoritesStore _favoritesStore = FavoritesStore();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _favoritesStore.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (_favoritesStore.quotes.isEmpty) {
        return Center(child: CircularProgressIndicator());
      } else {
        return LiquidPullToRefresh(
          showChildOpacityTransition: false,
          scrollController: _scrollController,
          onRefresh: () async {
            await _favoritesStore.load();
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _favoritesStore.quotes.length,
            itemBuilder: (context, index) {
              return QuoteWidget(_favoritesStore.quotes[index]);
            },
          ),
        );
      }
    });
  }
}
