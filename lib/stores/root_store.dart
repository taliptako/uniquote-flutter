import 'package:mobx/mobx.dart';

import 'package:uniquote/models/user_store.dart';

part 'root_store.g.dart';

class RootStore = _RootStore with _$RootStore;

abstract class _RootStore implements Store {
  @observable
  UserStore user;

  @observable
  int bottomNav = 0;

  @action
  void changeBottomNav(int index) {
    bottomNav = index;
  }
}
