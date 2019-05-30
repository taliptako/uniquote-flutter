import 'dart:convert';

import 'package:uniquote_flutter/models/comment_model.dart';
import 'package:uniquote_flutter/config/http.dart';

class CommentApi {
  Future<List<Comment>> fetchQuoteComments(int id) async {
    final r = await dio.get('quote/$id/comment');

    final json = jsonDecode(r.data);

    return json['data'].map<Comment>((json) => Comment.fromJson(json)).toList();
  }

  Future<Comment> storeComment(int id, String comment) async {
    final r = await dio.post('quote/$id/comment', data: {'comment': comment});

    final json = jsonDecode(r.data);

    return Comment.fromJson(json);
  }
}
