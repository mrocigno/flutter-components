import 'dart:async';

import 'package:domain/entity/Product.dart';
import 'package:flutter/material.dart';
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
                        FavoriteButton(
                          active: widget.model.favorite,
                          onPressed: (active) {
                            setState(() {
                              widget.model.favorite = active;
                            });
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
    );
  }

}
