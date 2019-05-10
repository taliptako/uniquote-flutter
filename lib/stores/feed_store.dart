import 'package:mobx/mobx.dart';

import 'package:uniquote/data/quote_api.dart';
import 'package:uniquote/models/quote_store.dart';

part 'feed_store.g.dart';

class FeedStore = _FeedStore with _$FeedStore;

abstract class _FeedStore implements Store {
  final QuoteApi _quoteApi = QuoteApi();

  @observable
  ObservableList<QuoteStore> quotes = ObservableList<QuoteStore>();

  @observable
  int page = 1;

  @observable
  String error;

  @action
  refresh() async {
    final result = await _quoteApi.fetchFeed(1);
    if (result == false) {
      error = "Error occurred while getting quotes";
    } else {
      quotes.clear();
      quotes.addAll(result);
    }
  }

  @action
  fetch() async {
    page++;
    final result = await _quoteApi.fetchFeed(page);
    if (result == false) {
      error = "Error occurred while getting quotes";
    } else {
      quotes.addAll(result);
    }
  }
}
