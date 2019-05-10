import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DB {
  Future get(String key) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(key)) {
      return prefs.getString(key);
    }
    return false;
  }

  Future set(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString(key, value);
  }

  Future remove(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.remove(key);
  }

  Future clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  decode(String data) {
    return jsonDecode(data);
  }
}
