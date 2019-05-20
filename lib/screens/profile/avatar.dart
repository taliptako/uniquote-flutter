import 'package:flutter/material.dart';

import 'package:flutter_advanced_networkimage/provider.dart';

import 'package:uniquote/config/sl.dart';
import 'package:uniquote/config/config.dart';
import 'package:uniquote/models/user_store.dart';

class Avatar extends StatelessWidget {
  final Config config = sl<Config>();
  final UserStore user;

  Avatar({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user.avatarLg != null) {
      return Container(
          width: MediaQuery.of(context).size.width / 3.7,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.elliptical(40, 40)),
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AdvancedNetworkImage(
                config.storageUrl + user.avatarLg,
                retryLimit: 1,
                useDiskCache: true,
                cacheRule: CacheRule(maxAge: const Duration(days: 7)),
              ),
            ),
          ));
    } else {
      return Container(
        width: MediaQuery.of(context).size.width / 3.7,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.all(Radius.elliptical(40, 40)),
        ),
        child: Center(
            child: Text(
          "${user.name[0]}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 33,
            fontWeight: FontWeight.bold,
          ),
        )),
      );
    }
  }
}
