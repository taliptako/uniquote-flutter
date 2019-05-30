import 'package:flutter/material.dart';

import 'package:flutter_advanced_networkimage/provider.dart';

import 'package:uniquote_flutter/config/sl.dart';
import 'package:uniquote_flutter/config/config.dart';
import 'package:uniquote_flutter/stores/root_store.dart';
import 'package:uniquote_flutter/screens/quote_detail_screen.dart';
import 'package:uniquote_flutter/models/quote_store.dart';

class QuoteDetail extends StatelessWidget {
  final QuoteStore quote;

  const QuoteDetail({Key key, this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quote"),
      ),
      bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Material(
            elevation: 16.0,
            child: Container(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 7, 0, 7),
                child: Row(
                  children: <Widget>[
                    _avatar(),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: TextField(
                        minLines: 1,
                        maxLines: 5,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            hintText: "Add a comment...",
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.send),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
      body: QuoteDetailScreen(quote: quote),
    );
  }

  CircleAvatar _avatar() {
    if (sl<RootStore>().user.avatarSm == null) {
      return CircleAvatar(
        radius: 22,
        child: Text(sl<RootStore>().user.name[0],
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
      );
    } else {
      return CircleAvatar(
        radius: 22,
        backgroundImage: AdvancedNetworkImage(
          sl<Config>().storageUrl + sl<RootStore>().user.avatarSm,
          retryLimit: 1,
          useDiskCache: true,
          cacheRule: CacheRule(maxAge: const Duration(days: 7)),
        ),
      );
    }
  }
}
