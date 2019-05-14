import 'package:mobx/mobx.dart';

import 'package:uniquote/data/quote_api.dart';
import 'package:uniquote/models/quote_store.dart';

part 'tag_recent_store.g.dart';

class TagRecentStore = _TagRecentStore with _$TagRecentStore;

abstract class _TagRecentStore implements Store {
  final QuoteApi _quoteApi = QuoteApi();

  @observable
  ObservableList<QuoteStore> quotes = ObservableList<QuoteStore>();

  @observable
  int page = 1;

  @observable
  String error;

  @action
  refresh(int id) async {
    final result = await _quoteApi.fetchTagRecent(id, 1);
    if (result == false) {
      error = "Error occurred while getting quotes";
    } else {
      quotes.clear();
      quotes.addAll(result);
    }
  }

  @action
  fetch(int id) async {
    page++;
    final result = await _quoteApi.fetchTagRecent(id, page);
    if (result == false) {
      error = "Error occurred while getting quotes";
    } else {
      quotes.addAll(result);
    }
  }
}
