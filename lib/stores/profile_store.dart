import 'package:mobx/mobx.dart';

import 'package:uniquote/data/quote_api.dart';
import 'package:uniquote/models/quote_store.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore implements Store {
  final QuoteApi _quoteApi = QuoteApi();

  @observable
  ObservableList<QuoteStore> quotes = ObservableList<QuoteStore>();

  @observable
  int page = 1;

  @observable
  bool isCompleted = false;

  @action
  fetch(int id) async {
    page++;
    final result = await _quoteApi.fetchUserQuotes(id, page);
    if (result is List<QuoteStore>) {
      isCompleted = true;
      quotes.addAll(result);
    }
  }
}