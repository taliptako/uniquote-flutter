import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:uniquote/stores/favorites_store.dart';
import 'package:uniquote/screens/favorites/favorites_quotes.dart';
import 'package:uniquote/screens/favorites/favorites_dropdown.dart';

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

    _favoritesStore.fetch();

    _favoritesStore.fetchUsers();
    _favoritesStore.fetchTags();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

      return CustomScrollView(controller: _scrollController, slivers: <Widget>[
        FavoritesDropdown(favoritesStore: _favoritesStore),
        FavoritesQuotes(favoritesStore: _favoritesStore)
      ]);
    });
  }
}
