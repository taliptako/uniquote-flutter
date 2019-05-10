// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$FeedStore on _FeedStore, Store {
  final _$quotesAtom = Atom(name: '_FeedStore.quotes');

  @override
  ObservableList<QuoteStore> get quotes {
    _$quotesAtom.reportObserved();
    return super.quotes;
  }

  @override
  set quotes(ObservableList<QuoteStore> value) {
    _$quotesAtom.context.checkIfStateModificationsAreAllowed(_$quotesAtom);
    super.quotes = value;
    _$quotesAtom.reportChanged();
  }

  final _$pageAtom = Atom(name: '_FeedStore.page');

  @override
  int get page {
    _$pageAtom.reportObserved();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.context.checkIfStateModificationsAreAllowed(_$pageAtom);
    super.page = value;
    _$pageAtom.reportChanged();
  }

  final _$errorAtom = Atom(name: '_FeedStore.error');

  @override
  String get error {
    _$errorAtom.reportObserved();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.context.checkIfStateModificationsAreAllowed(_$errorAtom);
    super.error = value;
    _$errorAtom.reportChanged();
  }

  final _$refreshAsyncAction = AsyncAction('refresh');

  @override
  Future refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$fetchAsyncAction = AsyncAction('fetch');

  @override
  Future fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }
}
