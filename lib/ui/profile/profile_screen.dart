import 'package:flutter/material.dart';

import 'package:uniquote_flutter/models/user_store.dart';
import 'package:uniquote_flutter/ui/profile/profile_section.dart';
import 'package:uniquote_flutter/ui/profile/profile_quotes.dart';

class ProfileScreen extends StatelessWidget {
  final UserStore user;

  ProfileScreen({Key key, this.user}) : super(key: key);

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverToBoxAdapter(
          // Put here all widgets that are not slivers.
          child: Container(
            margin: EdgeInsets.all(15),
            child: ProfileSection(user: user),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(left: 10),
            child: Text('Quotes',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w700)),
          ),
        ),
        ProfileQuotes(user: user, scrollController: _scrollController)
      ],
    );
  }
}
