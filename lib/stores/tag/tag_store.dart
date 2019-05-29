import 'package:mobx/mobx.dart';

import 'package:uniquote_flutter/models/tag_model.dart';
import 'package:uniquote_flutter/data/tag_api.dart';

part 'tag_store.g.dart';

class TagStore = _TagStore with _$TagStore;

abstract class _TagStore with Store {
  TagApi _tagApi = TagApi();

  @observable
  ObservableList<Tag> followedTags = ObservableList<Tag>();

  @observable
  ObservableList<Tag> unFollowedTags = ObservableList<Tag>();

  @observable
  Tag tag;

  @action
  fetchFollowed() async {
    final List<Tag> result = await _tagApi.fetchFollowedTags();

    followedTags.addAll(result);
  }

  @action
  fetchUnFollowed() async {
    final List<Tag> result = await _tagApi.fetchUnFollowedTags();

    unFollowedTags.addAll(result);
  }

  @action
  follow(int index, Tag tag) async {
    unFollowedTags.removeAt(index);
    followedTags.insert(0, tag);

    final bool result = await _tagApi.follow(tag.id);

    if (!result) {
      followedTags.removeAt(0);
      unFollowedTags.insert(index, tag);
    }
  }

  @action
  unFollow(int index, Tag tag) async {
    followedTags.removeAt(index);
    unFollowedTags.insert(0, tag);

    final bool result = await _tagApi.unFollow(tag.id);

    if (!result) {
      followedTags.insert(index, tag);
      unFollowedTags.removeAt(0);
    }
  }

  @action
  getTag(int id) async {
    tag = await _tagApi.fetchTag(id);
  }
}
