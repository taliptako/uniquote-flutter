import 'package:mobx/mobx.dart';

import 'package:uniquote/data/user_api.dart';
import 'package:uniquote/models/user_store.dart';

part 'normal_users_store.g.dart';

class NormalUsersStore = _NormalUsersStore with _$NormalUsersStore;

abstract class _NormalUsersStore implements Store {
  final UserApi _userApi = UserApi();

  @observable
  ObservableList<UserStore> users = ObservableList<UserStore>();

  @observable
  int page = 1;

  @action
  refresh() async {
    final result = await _userApi.fetchNormalUsers(1);
    if (result is List<UserStore>) {
      users.clear();
      users.addAll(result);
    }
  }

  @action
  fetch() async {
    page++;
    final result = await _userApi.fetchNormalUsers(page);
    users.addAll(result);
  }
}
