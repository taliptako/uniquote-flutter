import 'package:mobx/mobx.dart';

import 'package:uniquote/data/quote_api.dart';
import 'package:uniquote/models/quote_store.dart';

part 'favorites_store.g.dart';

class FavoritesStore = _FavoritesStore with _$FavoritesStore;

abstract class _FavoritesStore implements Store {
  final QuoteApi _quoteApi = QuoteApi();

  @observable
  ObservableList<QuoteStore> quotes = ObservableList<QuoteStore>();

  @observable
  int page = 1;

  @observable
  bool hasReachedEnd = false;

  @action
  refresh() async {
    final result = await _quoteApi.fetchUserFavorites(1);
    if (result is List<QuoteStore>) {
      quotes.addAll(result);
    }
  }

  @action
  fetch() async {
    final result = await _quoteApi.fetchUserFavorites(page);
    if (result.isEmpty) {
      hasReachedEnd = true;
    } else {
      page++;
      quotes.addAll(result);
    }
  }

}
