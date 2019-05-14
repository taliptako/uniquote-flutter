import 'package:uniquote/config/http.dart';
import 'package:uniquote/data/storage/db.dart';
import 'package:uniquote/models/quote_store.dart';

class QuoteApi {
  DB _db = DB();
  static const String table = "quotes";

  Future fetchFeed(int page) async {
    var body = await _db.get(table, 'feed$page');

    if (body == false) {
      final r = await dio.get('home?page=$page');
      body = r.data;
      await _db.set(table, 'feed$page', body);
    }

    final json = _db.decode(body);

    return json['data']
        .map<QuoteStore>((json) => AbstractQuoteStore.fromJson(json))
        .toList();
  }

  Future fetchMostLiked(int page) async {
    var body = await _db.get(table, 'most_liked$page');

    if (body == false) {
      final r = await dio.get('quote/most_liked?page=$page');
      body = r.data;
      _db.set(table, 'most_liked$page', body);
    }

    final json = _db.decode(body);

    return json['data']
        .map<QuoteStore>((json) => AbstractQuoteStore.fromJson(json))
        .toList();
  }

  Future fetchTagRecent(int id, int page) async {
    var body = await _db.get(table, '${id}_recent$page');

    if (body == false) {
      final r = await dio.get('tag/$id/recent?page=$page');
      body = r.data;
      await _db.set(table, '${id}_recent$page', body);
    }

    final json = _db.decode(body);

    return json['data']
        .map<QuoteStore>((json) => AbstractQuoteStore.fromJson(json))
        .toList();
  }

  Future fetchTagMostLiked(int id, int page) async {
    var body = await _db.get(table, '${id}_most_liked$page');

    if (body == false) {
      final r = await dio.get('tag/$id/most_liked?page=$page');
      body = r.data;
      await _db.set(table, '${id}_most_liked$page', body);
    }

    final json = _db.decode(body);

    return json['data']
        .map<QuoteStore>((json) => AbstractQuoteStore.fromJson(json))
        .toList();
  }


  Future fetchUserFavorites() async {
    var body = await _db.get(table, 'favorites');

    if (body == false) {
      final r = await dio.get('user_favorites');
      body = r.data;
      await _db.set(table, 'favorites', body);
    }

    final json = _db.decode(body);

    return json['data']
        .map<QuoteStore>((json) => AbstractQuoteStore.fromJson(json))
        .toList();
  }

  Future<bool> interact(String type, int id) async {
    try {
      await dio.put('quote/$id/$type');
      _db.truncateTable(table);
      return true;
    } catch (e) {
      return false;
    }
  }
}
