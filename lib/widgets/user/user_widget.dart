import 'package:flutter/material.dart';

import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:uniquote_flutter/models/user_store.dart';
import 'package:uniquote_flutter/config/sl.dart';
import 'package:uniquote_flutter/config/config.dart';

final Config config = sl<Config>();

class UserWidget extends StatelessWidget {
  final UserStore user;

  const UserWidget({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/profile', arguments: user);
          },
          child: Card(
            child: Row(
              children: <Widget>[Avatar(user), Name(user)],
            ),
          ),
        ));
  }
}

class Avatar extends StatelessWidget {
  const Avatar(this.user);

  final UserStore user;

  @override
  Widget build(BuildContext context) {
    if (user.avatarLg == null) {
      return Container(
        color: Colors.deepPurple,
        width: MediaQuery.of(context).size.width / 3.3,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('${user.name[0]}',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.white))
          ],
        ),
      );
    } else {
      return Container(
          width: MediaQuery.of(context).size.width / 3.3,
          height: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AdvancedNetworkImage(
                config.storageUrl + user.avatarLg,
                retryLimit: 1,
                useDiskCache: true,
                cacheRule: CacheRule(maxAge: const Duration(days: 7)),
              ),
            ),
          ));
    }
  }
}

class Name extends StatelessWidget {
  const Name(this.user);

  final UserStore user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: "${user.name} ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 17)),
                  user.nationality != null
                      ? TextSpan(
                          text: "${user.nationality} ",
                          style: TextStyle(fontSize: 14, color: Colors.teal))
                      : TextSpan(),
                  user.religion != null
                      ? TextSpan(
                          text: "${user.religion}",
                          style:
                              TextStyle(fontSize: 14, color: Colors.blueGrey))
                      : TextSpan(),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: "Born:",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      user.born != null
                          ? TextSpan(
                              text:
                                  "${user.born.year}-${user.born.month}-${user.born.day}",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400))
                          : TextSpan(),
                    ],
                  ),
                ),
              ),
              Observer(builder: (_) {
                if (user.isFollowed) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 3.8,
                    margin: EdgeInsets.only(right: 15, top: 10),
                    child: RaisedButton(
                      shape: StadiumBorder(),
                      onPressed: () {
                        user.unFollow();
                      },
                      color: Colors.amberAccent,
                      child: Text('UnFollow'),
                    ),
                  );
                }
                return Container(
                  width: MediaQuery.of(context).size.width / 3.8,
                  margin: EdgeInsets.only(right: 15, top: 10),
                  child: RaisedButton(
                    shape: StadiumBorder(),
                    onPressed: () {
                      user.follow();
                    },
                    color: Colors.greenAccent,
                    child: Text('Follow'),
                  ),
                );
              }),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
