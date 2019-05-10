import 'package:flutter/material.dart';

import 'package:flutter_advanced_networkimage/provider.dart';

import 'package:uniquote/config/sl.dart';
import 'package:uniquote/config/config.dart';
import 'package:uniquote/models/quote_store.dart';

class ProfileRow extends StatelessWidget {
  ProfileRow(this.quote);

  final QuoteStore quote;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          _avatar(),
          Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${quote.user.name}',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      )),
                  _professions()
                ],
              )),
        ],
      ),
    );
  }

  RichText _professions() {
    var spans = TextSpan(children: <TextSpan>[]);

    if (quote.user.professions.isNotEmpty) {
      quote.user.professions.sort((a, b) => b.count.compareTo(a.count));

      var professions = quote.user.professions.take(3);

      for (var profession in professions) {
        if (professions.first == profession) {
          spans.children.add(
            TextSpan(
              text: "${profession.name}",
              style: TextStyle(color: Colors.black),
            ),
          );
        } else {
          spans.children.add(
            TextSpan(
              text: " ${profession.name}",
              style: TextStyle(color: Colors.black),
            ),
          );
        }
      }
    }

    return RichText(
      text: spans,
    );
  }

  CircleAvatar _avatar() {
    if (quote.user.avatarSm == null) {
      return CircleAvatar(
        radius: 25,
        child: Text('${quote.user.name[0]}',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
      );
    } else {
      return CircleAvatar(
        radius: 25,
        backgroundImage: AdvancedNetworkImage(
          sl<Config>().storageUrl + quote.user.avatarSm,
          retryLimit: 1,
          useDiskCache: true,
          cacheRule: CacheRule(maxAge: const Duration(days: 7)),
        ),
      );
    }
  }
}

