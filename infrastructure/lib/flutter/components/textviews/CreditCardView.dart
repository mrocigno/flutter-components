/*
* Created to flutter-components at 05/21/2020
*/
import "dart:developer" as dev;

import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';

class CreditCardView extends StatefulWidget {

  final Gradient bgGradient;
  final String cardNumber;
  final String cardHolderName;
  final Widget entityFlag;

  CreditCardView({
    this.bgGradient,
    this.cardHolderName,
    this.cardNumber,
    this.entityFlag
  });

  @override
  _CreditCardViewState createState() => _CreditCardViewState();
}

class _CreditCardViewState extends State<CreditCardView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: widget.bgGradient
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            widget.entityFlag,
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: 10,
                  children: <Widget>[
                    Text(widget.cardHolderName, style: TextStyles.subtitleWhiteBold),
                    Text(widget.cardNumber.toUpperCase(), style: TextStyles.bodyWhite)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}




