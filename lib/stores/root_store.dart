import 'package:mobx/mobx.dart';
import 'package:dio/dio.dart';

import 'package:uniquote_flutter/controllers/auth_controller.dart';
import 'package:uniquote_flutter/models/user_store.dart';

part 'root_store.g.dart';

class RootStore = _RootStore with _$RootStore;

abstract class _RootStore with Store {
  final AuthController _authController = AuthController();

  @observable
  UserStore user;

  @observable
  int bottomNav = 0;

  @observable
  DioError error;

  @action
  void changeBottomNav(int index) {
    bottomNav = index;
  }

  @action
  changeUser(UserStore nUser) async {
    final UserStore sUser = await getSUser();
    nUser.apiToken = sUser.apiToken;
    user = nUser;
    await saveSUser(nUser);
  }

  @action
  incFollowing() async {
    final UserStore sUser = await getSUser();
    sUser.followingCount++;
    user.followingCount++;
    await saveSUser(sUser);
  }

  @action
  decFollowing() async {
    final UserStore sUser = await getSUser();
    sUser.followingCount--;
    user.followingCount--;
    await saveSUser(sUser);
  }

  Future<UserStore> getSUser() async {
    return await _authController.getUserFromStorage();
  }

  Future<void> saveSUser(UserStore nUser) async {
    await _authController.storeUserToStorage(nUser);
  }

  @action
  void logout() {
    user = new UserStore();
  }
}
