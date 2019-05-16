import 'package:uniquote/config/http.dart';
import 'package:uniquote/data/storage/db.dart';
import 'package:uniquote/models/user_store.dart';

class UserApi {
  DB _db = DB();
  static const String table = "users";

  Future fetchOfficialUsers(int page) async {
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

  Future fetchNormalUsers(int page) async {
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

  Future followUser(int userId) async {
    final r = await dio.put('user/$userId/follow');
    if(r.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future unFollowUser(int userId) async {
    final r = await dio.put('user/$userId/unfollow');
    if(r.statusCode == 200) {
      return true;
    }
    return false;
  }
}
