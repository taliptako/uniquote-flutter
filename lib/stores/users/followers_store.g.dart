// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followers_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$FollowersStore on _FollowersStore, Store {
  final _$usersAtom = Atom(name: '_FollowersStore.users');

  @override
  ObservableList<UserStore> get users {
    _$usersAtom.reportObserved();
    return super.users;
  }

  @override
  set users(ObservableList<UserStore> value) {
    _$usersAtom.context.checkIfStateModificationsAreAllowed(_$usersAtom);
    super.users = value;
    _$usersAtom.reportChanged();
  }

  final _$pageAtom = Atom(name: '_FollowersStore.page');

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

  final _$hasReachedEndAtom = Atom(name: '_FollowersStore.hasReachedEnd');

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

  final _$refreshAsyncAction = AsyncAction('refresh');

  @override
  Future refresh(int id) {
    return _$refreshAsyncAction.run(() => super.refresh(id));
  }

  final _$fetchAsyncAction = AsyncAction('fetch');

  @override
  Future fetch(int id) {
    return _$fetchAsyncAction.run(() => super.fetch(id));
  }
}
