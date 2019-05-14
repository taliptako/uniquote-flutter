import 'dart:convert';

import 'package:uniquote/config/http.dart';
import 'package:dio/dio.dart';

import 'package:uniquote/models/user_store.dart';

class AuthApi {
  Future socialLogin({
      String idToken, String email, String name, String isVerified}) async {
    Map data = {"id_token": idToken};
    if (email != null) {
      data.addAll({"email": email});
    }
    if (name != null) {
      data.addAll({"name": name});
    }
    if (isVerified != null) {
      data.addAll({"is_verified": isVerified});
    }

    try {
      final r = await dio.post('auth/social_login', data: data);

      final json = jsonDecode(r.data);

      return AbstractUserStore.fromJson(json['data']);
    } on DioError catch (e) {
      return false;
    }
  }

  Future register(String name, String email, String password,
      String passwordConfirmation) async {
    try {
      final r = await dio.post('auth/register', data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation
      });

      final json = jsonDecode(r.data);

      return AbstractUserStore.fromJson(json['data']);
    } on DioError catch (e) {
      return false;
    }
  }
}
