import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:uniquote/components/webview_holder.dart';
import 'package:uniquote/models/user_store.dart';
import 'package:uniquote/config/sl.dart';
import 'package:uniquote/stores/root_store.dart';

class Buttons extends StatelessWidget {
  final UserStore user;
  final RootStore _rootStore = sl<RootStore>();

  Buttons({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user.id == _rootStore.user.id) {
      return Container(
        width: MediaQuery.of(context).size.width / 2.3,
        margin: EdgeInsets.only(top: 12),
        child: RaisedButton(
          shape: StadiumBorder(),
          onPressed: () async {
            Navigator.pushNamed(context, '/profile_edit', arguments: user);
          },
          color: Colors.amberAccent,
          child: Text('Edit'),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        user.bioUrl != null
            ? Container(
                width: MediaQuery.of(context).size.width / 3.7,
                margin: EdgeInsets.only(top: 12),
                child: RaisedButton(
                  shape: StadiumBorder(),
                  onPressed: () async {
                    Navigator.pushNamed(context, '/webview',
                        arguments: WebViewHolder(
                          title: user.name,
                          url: user.bioUrl,
                        ));
                  },
                  color: Colors.grey,
                  child: Text('Wiki'),
                ),
              )
            : Container(),
        user.bioUrl != null ? SizedBox(width: 10) : SizedBox(width: 0),
        Observer(builder: (_) {
          if (user.isFollowed) {
            return Container(
              width: user.bioUrl != null
                  ? MediaQuery.of(context).size.width / 3.7
                  : MediaQuery.of(context).size.width / 2.5,
              margin: EdgeInsets.only(top: 12),
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
            width: user.bioUrl != null
                ? MediaQuery.of(context).size.width / 3.7
                : MediaQuery.of(context).size.width / 2.5,
            margin: EdgeInsets.only(top: 12),
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
    );
  }
}
