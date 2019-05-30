import 'package:uniquote_flutter/models/user_store.dart';

class Comment {
  final int id;
  final String comment;
  final DateTime createdAt;
  final UserStore user;

  const Comment({this.id, this.comment, this.createdAt, this.user});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        comment: json['comment'],
        createdAt: DateTime.parse(json['created_at']),
        user: AbstractUserStore.fromJson(json['user']));
  }
}
