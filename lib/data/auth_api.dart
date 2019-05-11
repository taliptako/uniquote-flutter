import 'dart:convert';

import 'package:uniquote/config/http.dart';
import 'package:dio/dio.dart';

import 'package:uniquote/models/user_store.dart';

class AuthApi {
  Future socialLogin(
      String idToken, String email, String name, String isVerified) async {
    Map data = {"id_token": idToken};
    if (email.isNotEmpty) {
      data.addAll({"email": email});
    }
    if (name.isNotEmpty) {
      data.addAll({"name": name});
    }
    if (isVerified.isNotEmpty) {
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
}
