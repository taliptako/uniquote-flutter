import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:uniquote_flutter/config/http.dart';
import 'package:uniquote_flutter/controllers/firebase_controller.dart';
import 'package:uniquote_flutter/config/sl.dart';
import 'package:uniquote_flutter/stores/root_store.dart';
import 'package:uniquote_flutter/models/user_store.dart';
import 'package:uniquote_flutter/data/auth_api.dart';
import 'package:uniquote_flutter/data/storage/db.dart';

class AuthController {
  final DB _db = DB();
  final _storage = FlutterSecureStorage();
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

    final result = await _authApi.socialLogin(await user.getIdToken());

    return loginProcess(result);
  }

  Future<bool> emailLogin(String email, String password) async {
    FirebaseUser user = await _firebaseController.emailLogin(email, password);

    final result = await _authApi.socialLogin(await user.getIdToken());
    return await loginProcess(result);
  }

  Future<bool> loginProcess(result, {clear = true}) async {
    if(clear) {
      await _db.deleteDB();
    }
    if (result is UserStore) {
      _rootStore.user = result;
      await storeUserToStorage(result);
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
      final sUser = await getUserFromStorage();
      if (sUser is UserStore) {
        return await loginProcess(sUser, clear: false);
      } else {
        final result = await _authApi.socialLogin(await user.getIdToken());
        return await loginProcess(result);
      }
    } else {
      return false;
    }
  }

  Future<void> storeUserToStorage(UserStore user) async {
    await _storage.write(key: "user", value: jsonEncode(user));
  }

  Future getUserFromStorage() async {
    final data = await _storage.read(key: 'user');
    if (data == null) {
      return false;
    }
    final UserStore user = AbstractUserStore.fromJson(jsonDecode(data));
    return user;
  }

  Future checkLocal(FirebaseUser fUser) async {
    final sUser = await getUserFromStorage();
    if (sUser is UserStore) {
      if (fUser.email == sUser.email) {
        sUser.apiToken = null;
        return sUser;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    await _firebaseController.logout();
    await _storage.delete(key: 'user');
    dio.options.headers.remove('Authorization');
    _rootStore.logout();
    return true;
  }
}
