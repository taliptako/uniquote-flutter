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

  final _$pageAtom = Atom(name: '_FavoritesStore.page');

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

  final _$hasReachedEndAtom = Atom(name: '_FavoritesStore.hasReachedEnd');

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

  final _$usersAtom = Atom(name: '_FavoritesStore.users');

  @override
  ObservableList<UserDropdown> get users {
    _$usersAtom.reportObserved();
    return super.users;
  }

  @override
  set users(ObservableList<UserDropdown> value) {
    _$usersAtom.context.checkIfStateModificationsAreAllowed(_$usersAtom);
    super.users = value;
    _$usersAtom.reportChanged();
  }

  final _$tagsAtom = Atom(name: '_FavoritesStore.tags');

  @override
  ObservableList<Tag> get tags {
    _$tagsAtom.reportObserved();
    return super.tags;
  }

  @override
  set tags(ObservableList<Tag> value) {
    _$tagsAtom.context.checkIfStateModificationsAreAllowed(_$tagsAtom);
    super.tags = value;
    _$tagsAtom.reportChanged();
  }

  final _$userIdAtom = Atom(name: '_FavoritesStore.userId');

  @override
  int get userId {
    _$userIdAtom.reportObserved();
    return super.userId;
  }

  @override
  set userId(int value) {
    _$userIdAtom.context.checkIfStateModificationsAreAllowed(_$userIdAtom);
    super.userId = value;
    _$userIdAtom.reportChanged();
  }

  final _$tagIdAtom = Atom(name: '_FavoritesStore.tagId');

  @override
  int get tagId {
    _$tagIdAtom.reportObserved();
    return super.tagId;
  }

  @override
  set tagId(int value) {
    _$tagIdAtom.context.checkIfStateModificationsAreAllowed(_$tagIdAtom);
    super.tagId = value;
    _$tagIdAtom.reportChanged();
  }

  final _$fetchUsersAsyncAction = AsyncAction('fetchUsers');

  @override
  Future fetchUsers() {
    return _$fetchUsersAsyncAction.run(() => super.fetchUsers());
  }

  final _$fetchTagsAsyncAction = AsyncAction('fetchTags');

  @override
  Future fetchTags() {
    return _$fetchTagsAsyncAction.run(() => super.fetchTags());
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

  final _$changeUserAsyncAction = AsyncAction('changeUser');

  @override
  Future changeUser(int id) {
    return _$changeUserAsyncAction.run(() => super.changeUser(id));
  }

  final _$changeTagAsyncAction = AsyncAction('changeTag');

  @override
  Future changeTag(int id) {
    return _$changeTagAsyncAction.run(() => super.changeTag(id));
  }
}
