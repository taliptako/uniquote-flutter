import 'package:mobx/mobx.dart';

import 'package:dio/dio.dart';

import 'package:uniquote_flutter/models/user_store.dart';

part 'root_store.g.dart';

class RootStore = _RootStore with _$RootStore;

abstract class _RootStore with Store {
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
  void logout() {
    user = new UserStore();
  }
}
