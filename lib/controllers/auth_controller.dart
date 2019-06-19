import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xxtea/xxtea.dart';

import 'package:uniquote_flutter/config/http.dart';
import 'package:uniquote_flutter/controllers/firebase_controller.dart';
import 'package:uniquote_flutter/config/sl.dart';
import 'package:uniquote_flutter/stores/root_store.dart';
import 'package:uniquote_flutter/models/user_store.dart';
import 'package:uniquote_flutter/data/auth_api.dart';
import 'package:uniquote_flutter/data/storage/db.dart';

class AuthController {
  final DB _db = DB();
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
    if (clear) {
      await _db.deleteDB();
    }
    if (result is UserStore) {
      sl<RootStore>().user = result;
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
      if (sUser is UserStore && sUser.email == user.email) {
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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String encUser =
        xxtea.encryptToString(jsonEncode(user.toJson()), "uhwesjkbsjkdasf");

    await prefs.setString('sUser', encUser);
  }

  Future getUserFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.get('sUser');
    if (data == null) {
      return false;
    }
    String decUser = xxtea.decryptToString(data, "uhwesjkbsjkdasf");

    final UserStore user = AbstractUserStore.fromJson(jsonDecode(decUser));
    return user;
  }

  Future<bool> deleteUserFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('sUser');
  }

  Future<bool> logout() async {
    await _firebaseController.logout();
    await deleteUserFromStorage();
    dio.options.headers.remove('Authorization');
    sl<RootStore>().logout();
    return true;
  }
}
