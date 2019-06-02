import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:uniquote_flutter/models/user_store.dart';

part 'root_store.g.dart';

class RootStore = _RootStore with _$RootStore;

abstract class _RootStore with Store {
  final _storage = FlutterSecureStorage();

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
    final data = await _storage.read(key: 'user');
    final UserStore sUser = AbstractUserStore.fromJson(jsonDecode(data));
    return sUser;
  }

  Future<void> saveSUser(UserStore nUser) async {
    await _storage.write(key: "user", value: jsonEncode(nUser.toJson()));
  }

  @action
  void logout() {
    user = new UserStore();
  }
}
