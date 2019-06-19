import 'package:flutter/material.dart';

import 'package:like_button/like_button.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pimp_my_button/pimp_my_button.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:uniquote_flutter/models/quote_store.dart';

class InteractionRow extends StatefulWidget {
  InteractionRow(this.quote);

  final QuoteStore quote;

  @override
  _InteractionRowState createState() => _InteractionRowState();
}

class _InteractionRowState extends State<InteractionRow> {
  bool _snapToEnd = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final QuoteStore quote = widget.quote;

    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.only(top: 7, bottom: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                LikeButton(
                  isLiked: quote.hasDisliked,
                  postion: Postion.left,
                  likeCount: quote.dislikeCount,
                  likeBuilder: (bool isDisliked) {
                    return Icon(
                      GroovinMaterialIcons.thumb_down_outline,
                      color: isDisliked ? Colors.deepPurpleAccent : Colors.grey,
                      size: 25,
                    );
                  },
                ),
                LikeButton(
                  onTap: (bool isLiked) async {
                    await quote.disLike();
                  },
                  isLiked: quote.hasLiked,
                  likeCount: quote.likeCount,
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      GroovinMaterialIcons.thumb_up_outline,
                      color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                      size: 25,
                    );
                  },
                ),
              ],
            ),
            LikeButton(
            ),
            Text('Comment')

          ],
        ),
      );
    });
  }
}
