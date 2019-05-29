import 'package:flutter/material.dart';

import 'package:flutter_advanced_networkimage/provider.dart';

import 'package:uniquote_flutter/widgets/quote/bottom_model.dart';
import 'package:uniquote_flutter/config/sl.dart';
import 'package:uniquote_flutter/config/config.dart';
import 'package:uniquote_flutter/models/quote_store.dart';

class ProfileRow extends StatelessWidget {
  ProfileRow(this.quote);

  final QuoteStore quote;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10, bottom: 3),
      child: Row(
        children: <Widget>[
          _avatar(),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${quote.user.name}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            )),
                        _professions()
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: IconButton(
                          icon: Icon(Icons.more_vert, size: 30),
                          onPressed: () {
                        showModalBottomSheet(
                            context: context, builder: (context) => BottomModal(quote));
                      }),
                    )
                  ],
                )),
          ),
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
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          );
        } else {
          spans.children.add(
            TextSpan(
              text: " ${profession.name}",
              style: TextStyle(color: Colors.black, fontSize: 12),
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
        radius: 22,
        child: Text('${quote.user.name[0]}',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
      );
    } else {
      return CircleAvatar(
        radius: 22,
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
