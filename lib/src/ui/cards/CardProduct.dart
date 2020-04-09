import 'dart:async';

import 'package:domain/entity/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/animations/ChainAnimations.dart';
import 'package:infrastructure/flutter/components/buttons/FavoriteButton.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'dart:developer' as dev;

class CardProduct extends StatefulWidget {

  final Product model;
  final Function onFavoriteButtonPressed;
  final bool hideWhenDisfavor;

  CardProduct({
    this.model,
    this.onFavoriteButtonPressed,
    this.hideWhenDisfavor = false
  });

  @override
  CardProductState createState() => CardProductState();
}

class CardProductState extends State<CardProduct> {
  bool showing = true;
  void hideCard() {
    setState(() {
      showing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChainAnimations(
      animations: [
        Animate(
          sequence: 1,
          builder: (child, started, onEnd) => AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: started? 0 : 1,
            onEnd: onEnd,
            child: child,
          ),
        ),
        Animate(
          sequence: 2,
          builder: (child, started, onEnd) => AnimatedContainer(
            duration: Duration(milliseconds: 100),
            child: child,
            height: started? 0 : 150,
          ),
        )
      ],
      startAnimation: !showing,
      child: Material(
        elevation: 2,
        color: Colors.white,
        // borderRadius: BorderRadius.all(Radius.circular(20)),
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: 150,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.network(widget.model.mainImageUrl,
                      alignment: Alignment.center,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    FavoriteButton(
                      active: widget.model.favorite,
                      onPressed: (active) {
                        if(!active && widget.hideWhenDisfavor) hideCard();
                        widget.model.favorite = active;
                        widget.onFavoriteButtonPressed?.call();
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Container(
                      width: 1,
                      color: Constants.Colors.BLACK_TRANSPARENT,
                      margin: EdgeInsets.symmetric(vertical: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.model.name, style: TextStyles.titleBlack),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5, bottom: 5),
                                child: Text("R\$"),
                              ),
                              Text("${widget.model.value}", style: TextStyle(fontSize: 30),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
