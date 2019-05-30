import 'package:flutter/material.dart';

import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:uniquote_flutter/config/sl.dart';
import 'package:uniquote_flutter/config/config.dart';
import 'package:uniquote_flutter/models/comment_model.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({Key key, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile',
                  arguments: comment.user);
              },
            child: _avatar(),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile',
                          arguments: comment.user);
                    },
                    child: Text(
                      comment.user.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 6),
                    child: Text(comment.comment),
                  ),
                  Text(timeago.format(comment.createdAt),
                      style: TextStyle(fontWeight: FontWeight.w300)),
                  SizedBox(height: 15),
                  Divider()
                ],
              ),
            ),
          ),
          SizedBox(width: 5)
        ],
      ),
    );
  }

  CircleAvatar _avatar() {
    if (comment.user.avatarSm == null) {
      return CircleAvatar(
        radius: 17,
        child: Text('${comment.user.name[0]}',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
      );
    } else {
      return CircleAvatar(
        radius: 17,
        backgroundImage: AdvancedNetworkImage(
          sl<Config>().storageUrl + comment.user.avatarSm,
          retryLimit: 1,
          useDiskCache: true,
          cacheRule: CacheRule(maxAge: const Duration(days: 7)),
        ),
      );
    }
  }
}
