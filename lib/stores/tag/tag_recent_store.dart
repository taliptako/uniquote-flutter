import 'package:mobx/mobx.dart';

import 'package:uniquote_flutter/data/quote_api.dart';
import 'package:uniquote_flutter/models/quote_store.dart';

part 'tag_recent_store.g.dart';

class TagRecentStore = _TagRecentStore with _$TagRecentStore;

abstract class _TagRecentStore with Store {
  final QuoteApi _quoteApi = QuoteApi();

  @observable
  ObservableList<QuoteStore> quotes = ObservableList<QuoteStore>();

  @observable
  int page = 1;

  @observable
  bool hasReachedEnd = false;

  @action
  refresh(int id) async {
    final result = await _quoteApi.fetchTagRecent(id, 1, clear: true);
    if (result is List<QuoteStore>) {
      quotes.clear();
      quotes.addAll(result);
    }
  }

  @action
  fetch(int id) async {
    final result = await _quoteApi.fetchTagRecent(id, page);
    if (result.isEmpty) {
      hasReachedEnd = true;
    } else {
      page++;
      quotes.addAll(result);
    }
  }
}
