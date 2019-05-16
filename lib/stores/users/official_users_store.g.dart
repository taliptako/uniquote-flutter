// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'official_users_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$OfficialUsersStore on _OfficialUsersStore, Store {
  final _$usersAtom = Atom(name: '_OfficialUsersStore.users');

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

  final _$pageAtom = Atom(name: '_OfficialUsersStore.page');

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

  final _$errorAtom = Atom(name: '_OfficialUsersStore.error');

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
