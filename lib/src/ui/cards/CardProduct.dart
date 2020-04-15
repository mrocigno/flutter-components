import 'dart:async';

import 'package:data/entity/Product.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/buttons/FavoriteButton.dart';
import 'package:infrastructure/flutter/components/textviews/Amount.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/utils/ScreenTransitions.dart';
import 'package:mopei_app/src/di/Injection.dart';
import 'package:mopei_app/src/ui/details/ProductDetails.dart';

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
  State<StatefulWidget> createState() => CardProductState();
}

class CardProductState extends State<CardProduct> with TickerProviderStateMixin {

  AnimationController controller;

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller = AnimationController(vsync: this,
      duration: Duration(milliseconds: 300),
    );

    Animation<double> opacity = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: controller, curve: Interval(0.0, 0.4, curve: Curves.ease))
    );
    Animation<double> size = Tween(begin: 150.0, end: 0.0).animate(
      CurvedAnimation(parent: controller, curve: Interval(0.4, 1.0, curve: Curves.ease))
    );

    if(!widget.model.favorite && widget.hideWhenDisfavor) controller.forward();

    return AnimatedBuilder(
      animation: opacity,
      builder: (context, child) {
        return Opacity(
          opacity: opacity.value,
          child: Material(
            elevation: 2,
            color: Colors.white,
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () => ScreenTransitions.push(context, ProductDetails(
                model: widget.model,
              )),
              child: Container(
                height: size.value,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Hero(tag: "image ${widget.model.localId}",
                            child: Image.network(widget.model.mainImageUrl,
                              alignment: Alignment.center,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ),
                          Hero(
                            tag: "favoriteStar ${widget.model.localId}",
                            child: FavoriteButton(
                              active: widget.model.favorite,
                              onPressed: (active) {
                                setState(() {
                                  widget.model.favorite = active;
                                });
                                widget.onFavoriteButtonPressed?.call();
                              },
                            ),
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
                                Amount(amount: widget.model.value)
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
          ),
        );
      }
    );
  }

}
