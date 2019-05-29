import 'dart:convert';

import 'package:uniquote_flutter/config/http.dart';
import 'package:dio/dio.dart';

import 'package:uniquote_flutter/models/user_store.dart';

class AuthApi {
  Future socialLogin(String idToken) async {
    try {
      final r =
          await dio.post('auth/social_login', data: {'id_token': idToken});

      final json = jsonDecode(r.data);

      return AbstractUserStore.fromJson(json['data']);
    } on DioError {
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
    } on DioError {
      return false;
    }
  }
}
