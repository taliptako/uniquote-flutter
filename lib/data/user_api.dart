import 'dart:convert';

import 'package:uniquote_flutter/config/http.dart';
import 'package:uniquote_flutter/data/storage/db.dart';
import 'package:uniquote_flutter/models/user_store.dart';
import 'package:uniquote_flutter/models/tag_model.dart';
import 'package:uniquote_flutter/models/user_dropdown.dart';

class UserApi {
  DB _db = DB();
  static const String table = "users";

  Future<List<UserStore>> fetchOfficialUsers(int page, {clear = false}) async {
    await clearPrefix(clear, 'official');

    var body = await _db.get(table, 'official$page');

    if (body == false) {
      final r = await dio.get('user?is_official=1&page=$page');
      body = r.data;
      await _db.set(table, 'official$page', body);
    }

    final json = _db.decode(body);

    return json['data']
        .map<UserStore>((json) => AbstractUserStore.fromJson(json))
        .toList();
  }

  Future<List<UserStore>> fetchNormalUsers(int page, {clear = false}) async {
    await clearPrefix(clear, 'normal');

    var body = await _db.get(table, 'normal$page');

    if (body == false) {
      final r = await dio.get('user?is_official=0&page=$page');
      body = r.data;
      await _db.set(table, 'normal$page', body);
    }

    final json = _db.decode(body);

    return json['data']
        .map<UserStore>((json) => AbstractUserStore.fromJson(json))
        .toList();
  }

  Future<UserStore> fetchUser(int id) async {
    final r = await dio.get('user/$id');

    final json = _db.decode(r.data);

    return AbstractUserStore.fromJson(json['data']);
  }

  Future<bool> followUser(int userId) async {
    try {
      await dio.put('user/$userId/follow');
      await _db.truncateTable(table);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> unFollowUser(int userId) async {
    try {
      await dio.put('user/$userId/unfollow');
      await _db.truncateTable(table);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<UserStore>> fetchUserFollowings(int id, int page) async {
    var body = await _db.get(table, '${id}_followings$page');

    if (body == false) {
      final r = await dio.get('user/$id/followings?page=$page');
      body = r.data;
      await _db.set(table, '${id}_followings$page', body);
    }

    final json = _db.decode(body);

    return json['data']
        .map<UserStore>((json) => AbstractUserStore.fromJson(json))
        .toList();
  }

  Future<List<UserStore>> fetchUserFollowers(int id, int page) async {
    var body = await _db.get(table, '${id}_followers$page');

    if (body == false) {
      final r = await dio.get('user/$id/followers?page=$page');
      body = r.data;
      await _db.set(table, '${id}_followers$page', body);
    }

    final json = _db.decode(body);

    return json['data']
        .map<UserStore>((json) => AbstractUserStore.fromJson(json))
        .toList();
  }

  Future<List<UserDropdown>> fetchFavoritedUsers() async {
    final r = await dio.get('favorited_users');

    final json = _db.decode(r.data);

    return json['data']
        .map<UserDropdown>((json) => UserDropdown.fromJson(json))
        .toList();
  }

  Future<List<Tag>> fetchFavoritedTags() async {
    final r = await dio.get('favorited_tags');

    final json = _db.decode(r.data);

    return json['data'].map<Tag>((json) => Tag.fromJson(json)).toList();
  }

  Future<UserStore> updateProfile(
      {DateTime birthDay, String bio, avatar}) async {
    Map data = {};
    if (birthDay != null) {
      data.addAll({'born': "$birthDay"});
    }
    if (bio != null && bio != "") {
      data.addAll({'bio': bio});
    }
    if (avatar != null) {
      data.addAll({'avatar_64': base64Encode(avatar.readAsBytesSync())});
    }

    final r = await dio.post('profile', data: data);

    final json = _db.decode(r.data);

    return AbstractUserStore.fromJson(json['data']);
  }

  Future<void> clearPrefix(bool clear, String prefix) async {
    if (clear) {
      await _db.removeByPrefix(table, prefix);
    }
  }
}
