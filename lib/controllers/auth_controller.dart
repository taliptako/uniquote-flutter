import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

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

    final result = await _authApi.socialLogin(await user.getIdToken(),
        user.email, user.displayName, user.isEmailVerified.toString());

    return loginProcess(result);
  }

  Future<bool> emailLogin(String email, String password) async {
    FirebaseUser user = await _firebaseController.emailLogin(email, password);

    final result = await _authApi.socialLogin(await user.getIdToken(),
        user.email, user.displayName, user.isEmailVerified.toString());
    return await loginProcess(result);
  }

  Future<bool> loginProcess(result) async {
    if (result is UserStore) {
      _rootStore.user = result;
      dio.options.headers = {'Authorization': 'Bearer ' + result.apiToken};
      return true;
    } else {
      await logout();
      return false;
    }
  }

  void successPush(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/0', (Route<dynamic> route) => false);
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
    return await _firebaseController.check();
  }

  Future<bool> logout() async {
    await _firebaseController.logout();
    dio.options.headers.remove('Authorization');
    _rootStore.user = null;
    return true;
  }
}
