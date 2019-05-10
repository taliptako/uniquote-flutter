// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$QuoteStore on AbstractQuoteStore, Store {
  final _$errorAtom = Atom(name: 'AbstractQuoteStore.error');

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

  final _$likeCountAtom = Atom(name: 'AbstractQuoteStore.likeCount');

  @override
  int get likeCount {
    _$likeCountAtom.reportObserved();
    return super.likeCount;
  }

  @override
  set likeCount(int value) {
    _$likeCountAtom.context
        .checkIfStateModificationsAreAllowed(_$likeCountAtom);
    super.likeCount = value;
    _$likeCountAtom.reportChanged();
  }

  final _$dislikeCountAtom = Atom(name: 'AbstractQuoteStore.dislikeCount');

  @override
  int get dislikeCount {
    _$dislikeCountAtom.reportObserved();
    return super.dislikeCount;
  }

  @override
  set dislikeCount(int value) {
    _$dislikeCountAtom.context
        .checkIfStateModificationsAreAllowed(_$dislikeCountAtom);
    super.dislikeCount = value;
    _$dislikeCountAtom.reportChanged();
  }

  final _$hasFavoritedAtom = Atom(name: 'AbstractQuoteStore.hasFavorited');

  @override
  bool get hasFavorited {
    _$hasFavoritedAtom.reportObserved();
    return super.hasFavorited;
  }

  @override
  set hasFavorited(bool value) {
    _$hasFavoritedAtom.context
        .checkIfStateModificationsAreAllowed(_$hasFavoritedAtom);
    super.hasFavorited = value;
    _$hasFavoritedAtom.reportChanged();
  }

  final _$hasLikedAtom = Atom(name: 'AbstractQuoteStore.hasLiked');

  @override
  bool get hasLiked {
    _$hasLikedAtom.reportObserved();
    return super.hasLiked;
  }

  @override
  set hasLiked(bool value) {
    _$hasLikedAtom.context.checkIfStateModificationsAreAllowed(_$hasLikedAtom);
    super.hasLiked = value;
    _$hasLikedAtom.reportChanged();
  }

  final _$hasDislikedAtom = Atom(name: 'AbstractQuoteStore.hasDisliked');

  @override
  bool get hasDisliked {
    _$hasDislikedAtom.reportObserved();
    return super.hasDisliked;
  }

  @override
  set hasDisliked(bool value) {
    _$hasDislikedAtom.context
        .checkIfStateModificationsAreAllowed(_$hasDislikedAtom);
    super.hasDisliked = value;
    _$hasDislikedAtom.reportChanged();
  }

  final _$favoriteAsyncAction = AsyncAction('favorite');

  @override
  Future favorite() {
    return _$favoriteAsyncAction.run(() => super.favorite());
  }

  final _$unFavoriteAsyncAction = AsyncAction('unFavorite');

  @override
  Future unFavorite() {
    return _$unFavoriteAsyncAction.run(() => super.unFavorite());
  }

  final _$likeAsyncAction = AsyncAction('like');

  @override
  Future like() {
    return _$likeAsyncAction.run(() => super.like());
  }

  final _$unLikeAsyncAction = AsyncAction('unLike');

  @override
  Future unLike() {
    return _$unLikeAsyncAction.run(() => super.unLike());
  }

  final _$disLikeAsyncAction = AsyncAction('disLike');

  @override
  Future disLike() {
    return _$disLikeAsyncAction.run(() => super.disLike());
  }

  final _$unDisLikeAsyncAction = AsyncAction('unDisLike');

  @override
  Future unDisLike() {
    return _$unDisLikeAsyncAction.run(() => super.unDisLike());
  }
}
