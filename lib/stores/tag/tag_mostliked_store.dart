import 'package:mobx/mobx.dart';

import 'package:uniquote_flutter/data/quote_api.dart';
import 'package:uniquote_flutter/models/quote_store.dart';

part 'tag_mostliked_store.g.dart';

class TagMostLikedStore = _TagMostLikedStore with _$TagMostLikedStore;

abstract class _TagMostLikedStore with Store {
  final QuoteApi _quoteApi = QuoteApi();

  @observable
  ObservableList<QuoteStore> quotes = ObservableList<QuoteStore>();

  @observable
  int page = 1;

  @observable
  bool hasReachedEnd = false;

  @action
  refresh(int id) async {
    final result = await _quoteApi.fetchTagMostLiked(id, 1, clear: true);
    if (result is List<QuoteStore>) {
      quotes.clear();
      quotes.addAll(result);
    }
  }

  @action
  fetch(int id) async {
    final result = await _quoteApi.fetchTagMostLiked(id, page);
    if (result.isEmpty) {
      hasReachedEnd = true;
    } else {
      page++;
      quotes.addAll(result);
    }
  }
}
