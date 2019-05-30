// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$QuoteDetailStore on _QuoteDetailStore, Store {
  final _$commentsAtom = Atom(name: '_QuoteDetailStore.comments');

  @override
  ObservableList<Comment> get comments {
    _$commentsAtom.reportObserved();
    return super.comments;
  }

  @override
  set comments(ObservableList<Comment> value) {
    _$commentsAtom.context.checkIfStateModificationsAreAllowed(_$commentsAtom);
    super.comments = value;
    _$commentsAtom.reportChanged();
  }

  final _$hasReachedEndAtom = Atom(name: '_QuoteDetailStore.hasReachedEnd');

  @override
  bool get hasReachedEnd {
    _$hasReachedEndAtom.reportObserved();
    return super.hasReachedEnd;
  }

  @override
  set hasReachedEnd(bool value) {
    _$hasReachedEndAtom.context
        .checkIfStateModificationsAreAllowed(_$hasReachedEndAtom);
    super.hasReachedEnd = value;
    _$hasReachedEndAtom.reportChanged();
  }

  final _$fetchCommentsAsyncAction = AsyncAction('fetchComments');

  @override
  Future fetchComments(int id) {
    return _$fetchCommentsAsyncAction.run(() => super.fetchComments(id));
  }
}
