// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'root_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$RootStore on _RootStore, Store {
  final _$userAtom = Atom(name: '_RootStore.user');

  @override
  UserStore get user {
    _$userAtom.reportObserved();
    return super.user;
  }

  @override
  set user(UserStore value) {
    _$userAtom.context.checkIfStateModificationsAreAllowed(_$userAtom);
    super.user = value;
    _$userAtom.reportChanged();
  }

  final _$bottomNavAtom = Atom(name: '_RootStore.bottomNav');

  @override
  int get bottomNav {
    _$bottomNavAtom.reportObserved();
    return super.bottomNav;
  }

  @override
  set bottomNav(int value) {
    _$bottomNavAtom.context
        .checkIfStateModificationsAreAllowed(_$bottomNavAtom);
    super.bottomNav = value;
    _$bottomNavAtom.reportChanged();
  }

  final _$errorAtom = Atom(name: '_RootStore.error');

  @override
  DioError get error {
    _$errorAtom.reportObserved();
    return super.error;
  }

  @override
  set error(DioError value) {
    _$errorAtom.context.checkIfStateModificationsAreAllowed(_$errorAtom);
    super.error = value;
    _$errorAtom.reportChanged();
  }

  final _$changeUserAsyncAction = AsyncAction('changeUser');

  @override
  Future changeUser(UserStore nUser) {
    return _$changeUserAsyncAction.run(() => super.changeUser(nUser));
  }

  final _$incFollowingAsyncAction = AsyncAction('incFollowing');

  @override
  Future incFollowing() {
    return _$incFollowingAsyncAction.run(() => super.incFollowing());
  }

  final _$decFollowingAsyncAction = AsyncAction('decFollowing');

  @override
  Future decFollowing() {
    return _$decFollowingAsyncAction.run(() => super.decFollowing());
  }

  final _$_RootStoreActionController = ActionController(name: '_RootStore');

  @override
  void changeBottomNav(int index) {
    final _$actionInfo = _$_RootStoreActionController.startAction();
    try {
      return super.changeBottomNav(index);
    } finally {
      _$_RootStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void logout() {
    final _$actionInfo = _$_RootStoreActionController.startAction();
    try {
      return super.logout();
    } finally {
      _$_RootStoreActionController.endAction(_$actionInfo);
    }
  }
}
