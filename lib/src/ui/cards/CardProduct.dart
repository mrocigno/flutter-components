import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/local/entity/Favorite.dart';
import 'package:data/local/entity/Product.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/animations/FadeAnimation.dart';
import 'package:infrastructure/flutter/components/buttons/FavoriteButton.dart';
import 'package:infrastructure/flutter/components/image/ImagePlaceholder.dart';
import 'package:infrastructure/flutter/components/textviews/Amount.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'dart:developer' as dev;

import 'package:mopei_app/src/ui/details/ProductDetailsScreen.dart';

typedef OnFavoriteButtonPressed = Function(Favorite favorite, bool active);
typedef OnCardClick = Function(Product product);

class CardProduct extends StatefulWidget {

  final Product model;
  final bool hideWhenDisfavor;
  final Function onHideAnimationEnd;
  final OnFavoriteButtonPressed onFavoriteButtonPressed;
  final OnCardClick onCardClick;

  CardProduct({
    this.model,
    this.onFavoriteButtonPressed,
    this.onCardClick,
    this.hideWhenDisfavor = false,
    this.onHideAnimationEnd
  });

  @override
  State<StatefulWidget> createState() => CardProductState();
}

class CardProductState extends State<CardProduct> {

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      duration: Duration(milliseconds: 300),
      onEnd: widget.onHideAnimationEnd,
      animate: ((widget.model.favorite == null) && widget.hideWhenDisfavor),
      child: Material(
        color: Colors.white,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () => widget.onCardClick?.call(widget.model),
          child: Container(
            height: 150,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: widget.model.mainImageUrl,
                          alignment: Alignment.center,
                          placeholder: (context, url) => ImagePlaceholder(),
                        ),
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
                        color: Constants.Colors.BLACK_TRANSPARENT_LOW,
                        margin: EdgeInsets.symmetric(vertical: 20),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.model.name, style: TextStyles.subtitleBlack),
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

}
