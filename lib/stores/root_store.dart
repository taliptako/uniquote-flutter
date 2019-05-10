import 'package:mobx/mobx.dart';

// Include generated file
part 'root_store.g.dart';

// This is the class used by rest of your codebase
class RootStore = _RootStore with _$RootStore;

// The store-class
abstract class _RootStore implements Store {

  @observable
  int bottomNav = 0;

  @action
  void changeBottomNav(int index) {
    bottomNav = index;
  }

}
