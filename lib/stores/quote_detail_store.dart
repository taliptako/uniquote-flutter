import 'package:mobx/mobx.dart';

import 'package:uniquote_flutter/models/comment_model.dart';
import 'package:uniquote_flutter/data/comment_api.dart';

part 'quote_detail_store.g.dart';

class QuoteDetailStore = _QuoteDetailStore with _$QuoteDetailStore;

abstract class _QuoteDetailStore with Store {
  final CommentApi _commentApi = CommentApi();

  @observable
  ObservableList<Comment> comments = ObservableList<Comment>();

  @observable
  bool hasReachedEnd = false;

  @action
  fetchComments(int id) async {
    final result = await _commentApi.fetchQuoteComments(id);
    if (result.isEmpty) {
      hasReachedEnd = true;
    } else {
      comments.addAll(result);
    }
  }
}
