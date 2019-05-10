import 'package:uniquote/config/http.dart';
import 'package:uniquote/data/storage/db.dart';
import 'package:uniquote/models/tag_model.dart';

class TagApi {
  DB _db = DB();

  Future<Tag> fetchTag(int id) async {
    var body = await _db.get('tag$id');

    if (body == false) {
      final r = await dio.get('tag/$id');
      body = r.data;
      _db.set('tag$id', body);
    }

    final json = _db.decode(body);

    return Tag.fromJson(json['data']);
  }

  Future<List<Tag>> fetchFollowedTags() async {
    var body = await _db.get('f_tags');

    if (body == false) {
      final r = await dio.get('tag/followed');
      body = r.data;
      _db.set('f_tags', body);
    }

    final json = _db.decode(body);

    return json['data'].map<Tag>((json) => Tag.fromJson(json)).toList();
  }

  Future<List<Tag>> fetchUnFollowedTags() async {
    var body = await _db.get('uf_tags');

    if (body == false) {
      final r = await dio.get('tag/unfollowed');
      body = r.data;
      _db.set('uf_tags', body);
    }

    final json = _db.decode(body);

    return json['data'].map<Tag>((json) => Tag.fromJson(json)).toList();
  }

  Future<bool> follow(int tagId) async {
    try {
      await dio.put('tag/$tagId/follow');
      _db.remove('f_tags');
      _db.remove('uf_tags');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> unFollow(int tagId) async {
    try {
      await dio.put('tag/$tagId/unfollow');
      _db.remove('f_tags');
      _db.remove('uf_tags');
      return true;
    } catch (e) {
      return false;
    }
  }
}
