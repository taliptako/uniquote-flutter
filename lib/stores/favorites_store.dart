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
  bool isCompleted = false;

  @action
  load() async {
    final result = await _quoteApi.fetchUserFavorites();
    if (result is List<QuoteStore>) {
      isCompleted = true;
      quotes.clear();
      quotes.addAll(result);
    }
  }
}
