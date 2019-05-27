import 'package:mobx/mobx.dart';

import 'package:uniquote/data/user_api.dart';
import 'package:uniquote/models/user_store.dart';

part 'followers_store.g.dart';

class FollowersStore = _FollowersStore with _$FollowersStore;

abstract class _FollowersStore with Store {
  final UserApi _userApi = UserApi();

  @observable
  ObservableList<UserStore> users = ObservableList<UserStore>();

  @observable
  int page = 1;

  @observable
  bool hasReachedEnd = false;

  @action
  refresh(int id) async {
    final result = await _userApi.fetchUserFollowers(id, 1);
    if (result is List<UserStore>) {
      users.clear();
      users.addAll(result);
    }
  }

  @action
  fetch(int id) async {
    final result = await _userApi.fetchUserFollowers(id, page);
    if (result.isEmpty) {
      hasReachedEnd = true;
    } else {
      page++;
      users.addAll(result);
    }
  }
}
