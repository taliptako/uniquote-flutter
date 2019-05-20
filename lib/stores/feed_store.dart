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

  @action
  refresh() async {
    final result = await _quoteApi.fetchFeed(1);
    if (result is List<QuoteStore>) {
      quotes.addAll(result);
    }
  }

  @action
  fetch() async {
    page++;
    final result = await _quoteApi.fetchFeed(page);
    quotes.addAll(result);
  }
}
