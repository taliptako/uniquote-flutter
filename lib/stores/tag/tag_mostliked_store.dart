import 'package:mobx/mobx.dart';

import 'package:uniquote/data/quote_api.dart';
import 'package:uniquote/models/quote_store.dart';

part 'tag_mostliked_store.g.dart';

class TagMostLikedStore = _TagMostLikedStore with _$TagMostLikedStore;

abstract class _TagMostLikedStore implements Store {
  final QuoteApi _quoteApi = QuoteApi();

  @observable
  ObservableList<QuoteStore> quotes = ObservableList<QuoteStore>();

  @observable
  int page = 1;

  @observable
  String error;

  @action
  refresh(int id) async {
    final result = await _quoteApi.fetchTagMostLiked(id, 1);
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
    final result = await _quoteApi.fetchTagMostLiked(id, page);
    if (result == false) {
      error = "Error occurred while getting quotes";
    } else {
      quotes.addAll(result);
    }
  }
}
