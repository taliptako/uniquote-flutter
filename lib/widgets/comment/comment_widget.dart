import 'package:flutter/material.dart';

import 'package:flutter_advanced_networkimage/provider.dart';

class CommentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 17,
            backgroundImage: AdvancedNetworkImage(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Tesla3.jpg/200px-Tesla3.jpg",
              retryLimit: 1,
              useDiskCache: true,
              cacheRule: CacheRule(maxAge: const Duration(days: 7)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Nikola Tesla',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 6),
                    child: Text(
                        'şlkdflş ajsdfklajsd f asdf jaıpod sjfka dsjfksd klfaj dklsfj lksdj afldk fjal'),
                  ),
                  Text('13 hours ago',
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
}
