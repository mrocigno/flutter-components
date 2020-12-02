/*
* Created to flutter-components at 05/21/2020
*/
import "dart:developer" as dev;

import 'package:flutter/material.dart';
import 'package:flutter_useful_things/components/textviews/EmptyState.dart';
import 'package:flutter_useful_things/components/textviews/TextStyles.dart';

class CreditCardView extends StatefulWidget {

  final Gradient bgGradient;
  final String cardNumber;
  final String cardHolderName;
  final Widget entityFlag;
  final bool isDefault;
  final bool removed;

  CreditCardView({
    this.bgGradient,
    this.cardHolderName,
    this.cardNumber,
    this.entityFlag,
    this.isDefault = false,
    this.removed = false
  });

  @override
  _CreditCardViewState createState() => _CreditCardViewState();
}

class _CreditCardViewState extends State<CreditCardView> {
  @override
  Widget build(BuildContext context) {
    const duration = const Duration(milliseconds: 300);

    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      elevation: 5,
      child: AnimatedContainer(
        duration: duration,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: widget.removed? removedGradient() : widget.bgGradient,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedOpacity(
              duration: duration,
              opacity: widget.removed? 0 : 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: widget.isDefault? (
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.flag, size: 30),
                          )
                        ) : Wrap(),
                      ),
                      widget.entityFlag,
                    ],
                  ),
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
            AnimatedContainer(
              duration: duration,
              width: widget.removed? 150 : 0,
              alignment: Alignment.center,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: <Widget>[
                  Icon(Icons.close, color: Colors.white, size: 100),
                  Text("Cartão removido", style: TextStyles.subtitleWhiteBold)
                ],
              )
            )
          ],
        )
      ),
    );
  }

  Gradient removedGradient() => LinearGradient(
    colors: [Colors.red.withRed(200), Colors.red.withOpacity(.8)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );
}




