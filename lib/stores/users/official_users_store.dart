import 'package:mobx/mobx.dart';

import 'package:uniquote/data/user_api.dart';
import 'package:uniquote/models/user_store.dart';

part 'official_users_store.g.dart';

class OfficialUsersStore = _OfficialUsersStore with _$OfficialUsersStore;

abstract class _OfficialUsersStore implements Store {
  final UserApi _userApi = UserApi();

  @observable
  ObservableList<UserStore> users = ObservableList<UserStore>();

  @observable
  int page = 1;

  @observable
  bool hasReachedEnd = false;

  @action
  refresh() async {
    final result = await _userApi.fetchOfficialUsers(1);
    if (result is List<UserStore>) {
      users.clear();
      users.addAll(result);
    }
  }

  @action
  fetch() async {
    final result = await _userApi.fetchOfficialUsers(page);
    if (result.isEmpty) {
      hasReachedEnd = true;
    } else {
      page++;
      users.addAll(result);
    }

  }
}
