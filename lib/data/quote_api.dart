import 'package:uniquote_flutter/config/http.dart';
import 'package:uniquote_flutter/data/storage/db.dart';
import 'package:uniquote_flutter/models/quote_store.dart';

class QuoteApi {
  DB _db = DB();
  static const String table = "quotes";

  Future<List<QuoteStore>> fetchFeed(int page, {clear = false}) async {
    await clearPrefix(clear, 'feed');

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

  Future<List<QuoteStore>> fetchMostLiked(int page, {clear = false}) async {
    await clearPrefix(clear, 'most_liked');

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

  Future<List<QuoteStore>> fetchTagRecent(int id, int page, {clear = false}) async {
    await clearPrefix(clear, '${id}_recent');

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

  Future<List<QuoteStore>> fetchTagMostLiked(int id, int page, {clear = false}) async {
    await clearPrefix(clear, '${id}_most_liked');

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

  Future<List<QuoteStore>> fetchUserFavorites(int page,
      {int userId, int tagId}) async {
    Map<String, int> data = {'page': page};
    if (userId != null) {
      data.addAll({'user_id': userId});
    }
    if (tagId != null) {
      data.addAll({'tag_id': tagId});
    }

    final r = await dio.get('user_favorites', queryParameters: data);

    final json = _db.decode(r.data);

    return json['data']
        .map<QuoteStore>((json) => AbstractQuoteStore.fromJson(json))
        .toList();
  }

  Future<List<QuoteStore>> fetchUserQuotes(int id, int page) async {
    var body = await _db.get(table, 'user_${id}_quotes$page');

    if (body == false) {
      final r = await dio.get('user/$id/quotes?page=$page');
      body = r.data;
      await _db.set(table, 'user_${id}_quotes$page', body);
    }

    final json = _db.decode(body);

    return json['data']
        .map<QuoteStore>((json) => AbstractQuoteStore.fromJson(json))
        .toList();
  }

  Future<bool> interact(String type, int id) async {
    try {
      await dio.put('quote/$id/$type');
      await _db.truncateTable(table);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> clearPrefix(bool clear, String prefix) async {
    if (clear) {
      await _db.removeByPrefix(table, prefix);
    }
  }
}
