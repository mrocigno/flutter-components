import 'dart:async';

import 'package:domain/entity/Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/buttons/FavoriteButton.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'dart:developer' as dev;

class CardHighlight extends StatelessWidget {

  final Item model;
  final Function onFavoriteButtonPressed;

  CardHighlight({
    this.model,
    this.onFavoriteButtonPressed
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: 250,
        height: 350,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.network(model.mainImageUrl,
                    alignment: Alignment.center,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  FavoriteButton(
                    active: model.favorite,
                    onPressed: (active) {
                      model.favorite = active;
                      onFavoriteButtonPressed?.call();
                    },
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    height: 1,
                    color: Constants.Colors.BLACK_TRANSPARENT,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.name, style: TextStyles.titleBlack),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5, bottom: 5),
                              child: Text("R\$"),
                            ),
                            Text("${model.value}", style: TextStyle(fontSize: 30),)
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
    );
  }

}
