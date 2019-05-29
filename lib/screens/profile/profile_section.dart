import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:uniquote_flutter/screens/profile/avatar.dart';
import 'package:uniquote_flutter/screens/profile/buttons.dart';
import 'package:uniquote_flutter/models/user_store.dart';

class ProfileSection extends StatefulWidget {
  final UserStore user;

  const ProfileSection({Key key, this.user}) : super(key: key);

  @override
  _ProfileSectionState createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
  void initState() {
    widget.user.getAdditional();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Avatar(user: widget.user),
            Expanded(
              child: Column(
                children: <Widget>[
                  Observer(builder: (_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/followers',
                                arguments: widget.user);
                          },
                          child: Column(
                            children: <Widget>[
                              Text("${widget.user.followerCount}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                'Followers',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/followings',
                                arguments: widget.user);
                          },
                          child: Column(
                            children: <Widget>[
                              Text("${widget.user.followingCount}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                'Followings',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text("${widget.user.quoteCount}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(
                              'Quotes',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    );
                  }),
                  Buttons(user: widget.user)
                ],
              ),
            ),
          ],
        ),
        widget.user.bio != null
            ? Container(
                margin: EdgeInsets.only(top: 15),
                child: Text("${widget.user.bio}"))
            : Container(),
      ],
    );
  }
}
