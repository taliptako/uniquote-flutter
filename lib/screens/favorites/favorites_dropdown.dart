import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:uniquote/stores/favorites_store.dart';
import 'package:uniquote/models/user_dropdown.dart';
import 'package:uniquote/models/tag_model.dart';

class FavoritesDropdown extends StatelessWidget {
  final FavoritesStore favoritesStore;

  const FavoritesDropdown({Key key, this.favoritesStore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Observer(
              builder: (_) => DropdownButtonHideUnderline(
                      child: DropdownButton(
                    iconSize: 30,
                    iconEnabledColor: Colors.deepPurple,
                    onChanged: (value) async {
                      await favoritesStore.changeUser(int.parse(value));
                    },
                    value: favoritesStore.userId != null
                        ? favoritesStore.userId.toString()
                        : "0",
                    items: favoritesStore.users.map((UserDropdown user) {
                      return new DropdownMenuItem<String>(
                        value: "${user.id}",
                        child: Text(user.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16)),
                      );
                    }).toList(),
                  ))),
          Observer(
              builder: (_) => DropdownButtonHideUnderline(
                      child: DropdownButton(
                    iconSize: 30,
                    iconEnabledColor: Colors.deepPurple,
                    onChanged: (value) async {
                      await favoritesStore.changeTag(int.parse(value));
                    },
                    value: favoritesStore.tagId != null
                        ? favoritesStore.tagId.toString()
                        : "0",
                    items: favoritesStore.tags.map((Tag tag) {
                      return new DropdownMenuItem<String>(
                        value: "${tag.id}",
                        child: Text(tag.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16)),
                      );
                    }).toList(),
                  ))),
        ],
      ),
    ));
  }
}
