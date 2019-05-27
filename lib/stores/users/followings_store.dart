import 'package:mobx/mobx.dart';

import 'package:uniquote/data/user_api.dart';
import 'package:uniquote/models/user_store.dart';

part 'followings_store.g.dart';

class FollowingsStore = _FollowingsStore with _$FollowingsStore;

abstract class _FollowingsStore with Store {
  final UserApi _userApi = UserApi();

  @observable
  ObservableList<UserStore> users = ObservableList<UserStore>();

  @observable
  int page = 1;

  @observable
  bool hasReachedEnd = false;

  @action
  refresh(int id) async {
    final result = await _userApi.fetchUserFollowings(id, 1);
    if (result is List<UserStore>) {
      users.clear();
      users.addAll(result);
    }
  }

  @action
  fetch(int id) async {
    final result = await _userApi.fetchUserFollowings(id, page);
    if (result.isEmpty) {
      hasReachedEnd = true;
    } else {
      page++;
      users.addAll(result);
    }
  }
}
