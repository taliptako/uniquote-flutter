import 'package:flutter/material.dart';

import 'package:random_color/random_color.dart';

import 'package:uniquote_flutter/models/tag_model.dart';
import 'package:uniquote_flutter/stores/tag/tag_store.dart';

class TagWidget extends StatelessWidget {
  TagWidget({this.tagStore, this.index, this.tag, this.text});

  final RandomColor _randomColor = RandomColor();
  final TagStore tagStore;

  final int index;
  final Tag tag;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/tag_list', arguments: tag);
        },
        child: Center(
            child: Container(
          margin: EdgeInsets.all(7),
          decoration: BoxDecoration(
              border: Border(
                  left:
                      BorderSide(color: _randomColor.randomColor(), width: 4))),
          child: Card(
            margin: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('${tag.name}',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                Row(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(right: 10),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          color: Colors.white,
                          child: Text(
                            text,
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            if (text == "Follow") {
                              tagStore.follow(index, tag);
                            } else {
                              tagStore.unFollow(index, tag);
                            }
                          },
                        )),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.arrow_forward_ios),
                    )
                  ],
                )
              ],
            ),
          ),
        )));
  }
}
