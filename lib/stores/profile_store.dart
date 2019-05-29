import 'package:mobx/mobx.dart';

import 'package:uniquote_flutter/data/quote_api.dart';
import 'package:uniquote_flutter/models/quote_store.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  final QuoteApi _quoteApi = QuoteApi();

  @observable
  ObservableList<QuoteStore> quotes = ObservableList<QuoteStore>();

  @observable
  int page = 1;

  @observable
  bool hasReachedEnd = false;

  @action
  fetch(int id) async {
    final result = await _quoteApi.fetchUserQuotes(id, page);
    if (result is List<QuoteStore> ) {
      if (result.isEmpty) {
        hasReachedEnd = true;
      } else {
        page++;
        quotes.addAll(result);
      }
    }
  }
}
