import 'dart:async';

import 'package:data/entity/Favorite.dart';
import 'package:data/entity/Product.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/buttons/FavoriteButton.dart';
import 'package:infrastructure/flutter/components/textviews/Amount.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/utils/ScreenTransitions.dart';
import 'package:mopei_app/src/ui/details/ProductDetails.dart';

typedef OnFavoriteButtonPressed = Function(Favorite favorite, bool active);

class CardProduct extends StatefulWidget {

  final Product model;
  final bool hideWhenDisfavor;
  final OnFavoriteButtonPressed onFavoriteButtonPressed;

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

    if((widget.model.favorite == null) && widget.hideWhenDisfavor) controller.forward();

    return AnimatedBuilder(
      animation: opacity,
      builder: (context, child) {
        return Opacity(
          opacity: opacity.value,
          child: Material(
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
                          Image.network(widget.model.mainImageUrl,
                            alignment: Alignment.center,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                          Hero(
                            tag: "favoriteStar ${widget.model.id}",
                            child: FavoriteButton(
                              active: widget.model.favorite != null,
                              onPressed: (active) {
                                setState(() {
                                  widget.onFavoriteButtonPressed?.call(Favorite(
                                      productId: widget.model.id
                                  ), active);
                                });
                              },
                            ),
                          ),
                          (widget.model.cart != null ?
                            Padding(
                              padding: const EdgeInsets.only(right: 45, top: 15),
                              child: Image.asset('assets/img/icCartActive.png', height: 20, width: 20,),
                            ) : Container()
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
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.model.name, style: TextStyles.titleBlack),
                                  Amount(amount: widget.model.value)
                                ],
                              ),
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
