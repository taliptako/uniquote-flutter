import 'package:flutter/material.dart';

import 'package:edge_alert/edge_alert.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:pimp_my_button/pimp_my_button.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:uniquote/models/quote_store.dart';

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
    reaction((_) => widget.quote.error, (msg) {
      EdgeAlert.show(context,
          icon: Icons.error,
          duration: 3,
          title: 'Error',
          backgroundColor: Colors.red,
          description: msg,
          gravity: EdgeAlert.BOTTOM);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final QuoteStore quote = widget.quote;

    return Observer(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("${quote.dislikeCount}"),
          ),
          PimpedButton(
            particle: DemoParticle(),
            pimpedWidgetBuilder: (context, controller) {
              return IconButton(
                icon: quote.hasDisliked
                    ? Icon(GroovinMaterialIcons.thumb_down,
                    color: Colors.deepPurple)
                    : Icon(GroovinMaterialIcons.thumb_down_outline),
                onPressed: () {
                  if (quote.hasDisliked) {
                    quote.unDisLike();
                  } else {
                    controller.forward(from: 0.0);
                    quote.disLike();
                  }
                },
              );
            },
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _snapToEnd = false;
              });
              if (quote.hasFavorited) {
                quote.unFavorite();
              } else {
                quote.favorite();
              }
            },
            child: Container(
              child: Container(
                  width: 50,
                  height: 23,
                  child: FlareActor("assets/flare/Favorite.flr",
                      fit: BoxFit.fitHeight,
                      shouldClip: false,
                      snapToEnd: _snapToEnd,

                      // Play the animation depending on the state.
                      animation: quote.hasFavorited
                          ? "Favorite"
                          : "Unfavorite" //_animationName
                  )),
            ),
          ),
          PimpedButton(
            particle: DemoParticle(),
            pimpedWidgetBuilder: (context, controller) {
              return IconButton(
                icon: quote.hasLiked
                    ? Icon(GroovinMaterialIcons.thumb_up,
                    color: Colors.deepPurple)
                    : Icon(GroovinMaterialIcons.thumb_up_outline),
                onPressed: () {
                  if (quote.hasLiked) {
                    quote.unLike();
                  } else {
                    controller.forward(from: 0.0);
                    quote.like();
                  }
                },
              );
            },
          ),
          Text("${quote.likeCount}")
        ],
      );
    });
  }
}