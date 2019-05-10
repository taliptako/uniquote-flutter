// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$TagStore on _TagStore, Store {
  final _$followedTagsAtom = Atom(name: '_TagStore.followedTags');

  @override
  ObservableList<Tag> get followedTags {
    _$followedTagsAtom.reportObserved();
    return super.followedTags;
  }

  @override
  set followedTags(ObservableList<Tag> value) {
    _$followedTagsAtom.context
        .checkIfStateModificationsAreAllowed(_$followedTagsAtom);
    super.followedTags = value;
    _$followedTagsAtom.reportChanged();
  }

  final _$unFollowedTagsAtom = Atom(name: '_TagStore.unFollowedTags');

  @override
  ObservableList<Tag> get unFollowedTags {
    _$unFollowedTagsAtom.reportObserved();
    return super.unFollowedTags;
  }

  @override
  set unFollowedTags(ObservableList<Tag> value) {
    _$unFollowedTagsAtom.context
        .checkIfStateModificationsAreAllowed(_$unFollowedTagsAtom);
    super.unFollowedTags = value;
    _$unFollowedTagsAtom.reportChanged();
  }

  final _$tagAtom = Atom(name: '_TagStore.tag');

  @override
  Tag get tag {
    _$tagAtom.reportObserved();
    return super.tag;
  }

  @override
  set tag(Tag value) {
    _$tagAtom.context.checkIfStateModificationsAreAllowed(_$tagAtom);
    super.tag = value;
    _$tagAtom.reportChanged();
  }

  final _$fetchFollowedAsyncAction = AsyncAction('fetchFollowed');

  @override
  Future fetchFollowed() {
    return _$fetchFollowedAsyncAction.run(() => super.fetchFollowed());
  }

  final _$fetchUnFollowedAsyncAction = AsyncAction('fetchUnFollowed');

  @override
  Future fetchUnFollowed() {
    return _$fetchUnFollowedAsyncAction.run(() => super.fetchUnFollowed());
  }

  final _$followAsyncAction = AsyncAction('follow');

  @override
  Future follow(int index, Tag tag) {
    return _$followAsyncAction.run(() => super.follow(index, tag));
  }

  final _$unFollowAsyncAction = AsyncAction('unFollow');

  @override
  Future unFollow(int index, Tag tag) {
    return _$unFollowAsyncAction.run(() => super.unFollow(index, tag));
  }

  final _$getTagAsyncAction = AsyncAction('getTag');

  @override
  Future getTag(int id) {
    return _$getTagAsyncAction.run(() => super.getTag(id));
  }
}
