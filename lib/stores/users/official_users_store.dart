import 'package:mobx/mobx.dart';

import 'package:uniquote_flutter/data/user_api.dart';
import 'package:uniquote_flutter/models/user_store.dart';

part 'official_users_store.g.dart';

class OfficialUsersStore = _OfficialUsersStore with _$OfficialUsersStore;

abstract class _OfficialUsersStore with Store {
  final UserApi _userApi = UserApi();

  @observable
  ObservableList<UserStore> users = ObservableList<UserStore>();

  @observable
  int page = 1;

  @observable
  bool hasReachedEnd = false;

  @action
  refresh() async {
    final result = await _userApi.fetchOfficialUsers(1, clear: true);
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
