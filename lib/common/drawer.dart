import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:uniquote_flutter/config/sl.dart';
import 'package:uniquote_flutter/config/config.dart';
import 'package:uniquote_flutter/stores/root_store.dart';
import 'package:uniquote_flutter/controllers/auth_controller.dart';

class DrawerWidget extends StatelessWidget {
  final RootStore _rootStore = sl.get<RootStore>();
  final Config _config = sl.get<Config>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          drawerHeader(context),
          Menu(),
        ],
      ),
    );
  }

  Container drawerHeader(BuildContext context) {
    return Container(
      height: 300,
      child: DrawerHeader(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[avatar(context), stats(context)],
        ),
      ),
    );
  }

  Row avatar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '3');
          },
          child: Column(
            children: <Widget>[
              _rootStore.user.avatarLg == null
                  ? CircleAvatar(
                      radius: 45,
                      child: Text('${_rootStore.user.name[0]}',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600)),
                    )
                  : CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                          "${_config.storageUrl + _rootStore.user.avatarLg}"),
                    ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text("${_rootStore.user.name}",
                    style: TextStyle(
                      fontSize: 20,
                    )),
              )
            ],
          ),
        )
      ],
    );
  }

  Observer stats(BuildContext context) {
    return Observer(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/favorites');
            },
            child: Column(
              children: <Widget>[
                Text(
                  "${_rootStore.user.favoriteCount}",
                  style: TextStyle(fontSize: 28),
                ),
                Text('favorites')
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '3');
            },
            child: Column(
              children: <Widget>[
                Text(
                  "${_rootStore.user.quoteCount}",
                  style: TextStyle(fontSize: 28),
                ),
                Text('quotes')
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/followers',
                  arguments: _rootStore.user);
            },
            child: Column(
              children: <Widget>[
                Text(
                  "${_rootStore.user.followerCount}",
                  style: TextStyle(fontSize: 28),
                ),
                Text('follower')
              ],
            ),
          ),
        ],
      );
    });
  }
}

class Menu extends StatelessWidget {
  final RootStore _rootStore = sl.get<RootStore>();
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.star),
          title: Text('Favorites'),
          onTap: () {
            Navigator.pushNamed(context, '/favorites');
          },
        ),
        ListTile(
          leading: Icon(Icons.library_books),
          title: Text('About'),
          onTap: () {
            Navigator.pushNamed(context, '/about');
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Log Out'),
          onTap: () async {
            final bool result = await _authController.logout();
            if (result == true) {
              _authController.logoutPush(context);
            }
          },
        ),
      ],
    );
  }
}
