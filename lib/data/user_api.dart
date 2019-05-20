import 'package:uniquote/config/http.dart';
import 'package:uniquote/data/storage/db.dart';
import 'package:uniquote/models/user_store.dart';

class UserApi {
  DB _db = DB();
  static const String table = "users";

  Future<List<UserStore>> fetchOfficialUsers(int page) async {
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

  Future<List<UserStore>> fetchNormalUsers(int page) async {
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
    final r = await dio.put('user/$userId/follow');
    if (r.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> unFollowUser(int userId) async {
    final r = await dio.put('user/$userId/unfollow');
    if (r.statusCode == 200) {
      return true;
    }
    return false;
  }
}
