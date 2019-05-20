// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$FavoritesStore on _FavoritesStore, Store {
  final _$quotesAtom = Atom(name: '_FavoritesStore.quotes');

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

  final _$isCompletedAtom = Atom(name: '_FavoritesStore.isCompleted');

  @override
  bool get isCompleted {
    _$isCompletedAtom.reportObserved();
    return super.isCompleted;
  }

  @override
  set isCompleted(bool value) {
    _$isCompletedAtom.context
        .checkIfStateModificationsAreAllowed(_$isCompletedAtom);
    super.isCompleted = value;
    _$isCompletedAtom.reportChanged();
  }

  final _$loadAsyncAction = AsyncAction('load');

  @override
  Future load() {
    return _$loadAsyncAction.run(() => super.load());
  }
}
