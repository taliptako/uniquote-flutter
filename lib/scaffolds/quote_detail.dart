import 'package:flutter/material.dart';

import 'package:flutter_advanced_networkimage/provider.dart';

import 'package:uniquote_flutter/config/sl.dart';
import 'package:uniquote_flutter/config/config.dart';
import 'package:uniquote_flutter/components/dialoger.dart';
import 'package:uniquote_flutter/components/progress.dart';
import 'package:uniquote_flutter/models/comment_model.dart';
import 'package:uniquote_flutter/data/comment_api.dart';
import 'package:uniquote_flutter/stores/root_store.dart';
import 'package:uniquote_flutter/screens/quote_detail_screen.dart';
import 'package:uniquote_flutter/models/quote_store.dart';

class QuoteDetail extends StatelessWidget {
  final QuoteStore quote;

  QuoteDetail({Key key, this.quote}) : super(key: key);

  final CommentApi _commentApi = CommentApi();

  final _commentController = TextEditingController();

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
              margin: EdgeInsets.fromLTRB(10, 7, 0, 7),
              child: Row(
                children: <Widget>[
                  _avatar(),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    width: MediaQuery.of(context).size.width / 1.6,
                    child: TextField(
                      controller: _commentController,
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
                      onPressed: () async {
                        if (_commentController.text.length < 3) {
                          Dialoger(context).redAlert('Comment Failed',
                              'Please use more than two characters !');
                          return false;
                        }
                        Progress.show(context);
                        final result = await _commentApi.storeComment(
                            quote.id, _commentController.text);
                        Progress.hide(context);
                        if (result == true) {
                          Dialoger(context).added('Comment Added',
                              'Your new comment added successfully. Thank you!');
                          Navigator.pushReplacementNamed(
                              context, '/quote_detail',
                              arguments: quote);
                        } else {
                          Dialoger(context).redAlert('Comment Failed',
                              'Error occured while sending comment');
                        }
                      },
                      iconSize: 30,
                      icon: Icon(Icons.send),
                    ),
                  )
                ],
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
