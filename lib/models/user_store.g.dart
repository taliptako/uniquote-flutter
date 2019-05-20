// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$UserStore on AbstractUserStore, Store {
  final _$favoriteCountAtom = Atom(name: 'AbstractUserStore.favoriteCount');

  @override
  int get favoriteCount {
    _$favoriteCountAtom.reportObserved();
    return super.favoriteCount;
  }

  @override
  set favoriteCount(int value) {
    _$favoriteCountAtom.context
        .checkIfStateModificationsAreAllowed(_$favoriteCountAtom);
    super.favoriteCount = value;
    _$favoriteCountAtom.reportChanged();
  }

  final _$isFollowedAtom = Atom(name: 'AbstractUserStore.isFollowed');

  @override
  bool get isFollowed {
    _$isFollowedAtom.reportObserved();
    return super.isFollowed;
  }

  @override
  set isFollowed(bool value) {
    _$isFollowedAtom.context
        .checkIfStateModificationsAreAllowed(_$isFollowedAtom);
    super.isFollowed = value;
    _$isFollowedAtom.reportChanged();
  }

  final _$followerCountAtom = Atom(name: 'AbstractUserStore.followerCount');

  @override
  int get followerCount {
    _$followerCountAtom.reportObserved();
    return super.followerCount;
  }

  @override
  set followerCount(int value) {
    _$followerCountAtom.context
        .checkIfStateModificationsAreAllowed(_$followerCountAtom);
    super.followerCount = value;
    _$followerCountAtom.reportChanged();
  }

  final _$followingCountAtom = Atom(name: 'AbstractUserStore.followingCount');

  @override
  int get followingCount {
    _$followingCountAtom.reportObserved();
    return super.followingCount;
  }

  @override
  set followingCount(int value) {
    _$followingCountAtom.context
        .checkIfStateModificationsAreAllowed(_$followingCountAtom);
    super.followingCount = value;
    _$followingCountAtom.reportChanged();
  }

  final _$quoteCountAtom = Atom(name: 'AbstractUserStore.quoteCount');

  @override
  int get quoteCount {
    _$quoteCountAtom.reportObserved();
    return super.quoteCount;
  }

  @override
  set quoteCount(int value) {
    _$quoteCountAtom.context
        .checkIfStateModificationsAreAllowed(_$quoteCountAtom);
    super.quoteCount = value;
    _$quoteCountAtom.reportChanged();
  }

  final _$followAsyncAction = AsyncAction('follow');

  @override
  Future follow() {
    return _$followAsyncAction.run(() => super.follow());
  }

  final _$unFollowAsyncAction = AsyncAction('unFollow');

  @override
  Future unFollow() {
    return _$unFollowAsyncAction.run(() => super.unFollow());
  }

  final _$getAdditionalAsyncAction = AsyncAction('getAdditional');

  @override
  Future getAdditional() {
    return _$getAdditionalAsyncAction.run(() => super.getAdditional());
  }
}
