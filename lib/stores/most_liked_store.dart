import 'package:mobx/mobx.dart';

import 'package:uniquote_flutter/data/quote_api.dart';
import 'package:uniquote_flutter/models/quote_store.dart';

part 'most_liked_store.g.dart';

class MostLikedStore = _MostLikedStore with _$MostLikedStore;

abstract class _MostLikedStore with Store {
  final QuoteApi _quoteApi = QuoteApi();

  @observable
  ObservableList<QuoteStore> quotes = ObservableList<QuoteStore>();

  @observable
  int page = 1;

  @observable
  bool hasReachedEnd = false;

  @action
  refresh() async {
    final result = await _quoteApi.fetchMostLiked(1, clear: true);
    if (result is List<QuoteStore>) {
      quotes.clear();
      quotes.addAll(result);
    }
  }

  @action
  fetch() async {
    final result = await _quoteApi.fetchMostLiked(page);
    if (result.isEmpty) {
      hasReachedEnd = true;
    } else {
      page++;
      quotes.addAll(result);
    }
  }
}
