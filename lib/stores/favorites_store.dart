import 'package:mobx/mobx.dart';

import 'package:uniquote/data/quote_api.dart';
import 'package:uniquote/data/user_api.dart';
import 'package:uniquote/models/tag_model.dart';
import 'package:uniquote/models/quote_store.dart';
import 'package:uniquote/models/user_dropdown.dart';

part 'favorites_store.g.dart';

class FavoritesStore = _FavoritesStore with _$FavoritesStore;

abstract class _FavoritesStore with Store {
  final QuoteApi _quoteApi = QuoteApi();
  final UserApi _userApi = UserApi();

  @observable
  ObservableList<QuoteStore> quotes = ObservableList<QuoteStore>();

  @observable
  int page = 1;

  @observable
  bool hasReachedEnd = false;

  @observable
  ObservableList<UserDropdown> users = ObservableList<UserDropdown>();

  @observable
  ObservableList<Tag> tags = ObservableList<Tag>();

  @observable
  int userId;

  @observable
  int tagId;

  @action
  fetchUsers() async {
    final result = await _userApi.fetchFavoritedUsers();
    if (result is List<UserDropdown>) {
      List<UserDropdown> data = [UserDropdown(id: 0, name: "All")];
      users.addAll(data);
      users.addAll(result);
    }
  }

  @action
  fetchTags() async {
    final result = await _userApi.fetchFavoritedTags();
    if (result is List<Tag>) {
      List<Tag> data = [Tag(id: 0, name: "All", count: 0)];
      tags.addAll(data);
      tags.addAll(result);
    }
  }

  @action
  refresh() async {
    final result =
        await _quoteApi.fetchUserFavorites(1, userId: userId, tagId: tagId);
    print(result);
    if (result is List<QuoteStore>) {
      quotes.clear();
      quotes.addAll(result);
    }
  }

  @action
  fetch() async {
    final result =
        await _quoteApi.fetchUserFavorites(page, userId: userId, tagId: tagId);
    if (result.isEmpty) {
      hasReachedEnd = true;
    } else {
      page++;
      quotes.addAll(result);
    }
  }

  @action
  changeUser(int id) async {
    userId = id;
    refresh();
  }

  @action
  changeTag(int id) async {
    tagId = id;
    refresh();
  }
}
