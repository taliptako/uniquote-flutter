import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:uniquote/config/http.dart';
import 'package:uniquote/controllers/firebase_controller.dart';
import 'package:uniquote/config/sl.dart';
import 'package:uniquote/stores/root_store.dart';
import 'package:uniquote/models/user_store.dart';
import 'package:uniquote/data/auth_api.dart';

class AuthController {
  final RootStore _rootStore = sl<RootStore>();
  final FirebaseController _firebaseController = FirebaseController();
  final AuthApi _authApi = AuthApi();

  Future register(name, email, password, passwordConfirmation) async {
    final result =
        await _authApi.register(name, email, password, passwordConfirmation);

    if (result is UserStore) {
      await _firebaseController.emailRegister(email, password);
      return loginProcess(result);
    }
  }

  Future<bool> googleLogin() async {
    FirebaseUser user = await _firebaseController.googleLogin();

    print(await user.getIdToken());
    final result = await _authApi.socialLogin(await user.getIdToken());

    return loginProcess(result);
  }

  Future<bool> emailLogin(String email, String password) async {
    FirebaseUser user = await _firebaseController.emailLogin(email, password);

    final result = await _authApi.socialLogin(await user.getIdToken());
    return await loginProcess(result);
  }

  Future<bool> loginProcess(result) async {
    if (result is UserStore) {
      _rootStore.user = result;
      dio.options.headers = {'Authorization': 'Bearer ${result.apiToken}'};
      return true;
    } else {
      await logout();
      return false;
    }
  }

  void successPush(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/tabs', (Route<dynamic> route) => false);
  }

  void logoutPush(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  void registerPush(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/register', (Route<dynamic> route) => false);
  }

  Future check() async {
    var user = await _firebaseController.check();

    if (user is FirebaseUser) {
      final result = await _authApi.socialLogin(await user.getIdToken());
      return await loginProcess(result);
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    await _firebaseController.logout();
    dio.options.headers.remove('Authorization');
    _rootStore.logout();
    return true;
  }
}
