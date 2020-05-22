/*
* Created to flutter-components at 05/17/2020
*/
import "dart:developer" as dev;

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:infrastructure/flutter/components/inputs/FormValidate.dart';
import 'package:infrastructure/flutter/components/inputs/InputController.dart';
import 'package:infrastructure/flutter/components/inputs/InputText.dart';
import 'package:infrastructure/flutter/utils/Functions.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;

class CreditCardForm extends StatefulWidget {

  @override
  _CreditCardFormState createState() => _CreditCardFormState();

}

class _CreditCardFormState extends State<CreditCardForm> with SingleTickerProviderStateMixin {

  FocusNode cvvFocus = FocusNode();
  var cvvHasFocus = false;
  var oldCvvStatus = false;
  AnimationController _controller;

  InputController numCardController = InputController();
  InputController expireDateController = InputController();
  InputController cvvController = InputController();
  InputController nameController = InputController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    cvvFocus.addListener(() => setState(() {
      cvvHasFocus = !cvvHasFocus;
    }));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    numCardController.dispose();
    expireDateController.dispose();
    cvvController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Animation<double> animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: .7), weight: 1.0),
      TweenSequenceItem(tween: Tween(begin: .7, end: 1.0), weight: 1.0),
    ]).animate(_controller);

    if(oldCvvStatus != cvvHasFocus){
      _controller.forward().then((value) => _controller.reset());
      oldCvvStatus = cvvHasFocus;
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 2,
            child: Container(
              width: widthByPercent(context, 80),
              height: widthByPercent(context, 45),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -16,
                    bottom: -16,
                    right: -16,
                    left: -16,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) => ScaleTransition(
                        scale: animation,
                        child: CreditCardWidget(
                          animationDuration: Duration(milliseconds: 1000),
                          cardNumber: "5346123412341234",
                          expiryDate: "02/25",
                          cardHolderName: "Matheus",
                          cvvCode: "222",
                          cardbgColor: Constants.Colors.PRIMARY_SWATCH,
                          showBackView: cvvHasFocus,
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
          ),
        ),
        FormValidate(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Constants.Colors.BACKGROUND_MARBLE_MEDIUM
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Input(InputThemes.loginTheme,
                margin: const EdgeInsets.symmetric(vertical: 20),
                hint: "Número do cartão",
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Input(InputThemes.loginTheme,
                        margin: const EdgeInsets.only(bottom: 20, right: 10),
                        hint: "Data de validade",
                      )
                  ),
                  Expanded(
                    flex: 1,
                    child: Input(InputThemes.loginTheme,
                      margin: const EdgeInsets.only(bottom: 20, left: 10),
                      hint: "CVV",
                      focusNode: cvvFocus,
                    ),
                  )
                ],
              ),
              Input(InputThemes.loginTheme,
                margin: const EdgeInsets.only(bottom: 20),
                hint: "Nome do proprietario",
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CreditCardModel {

  String number;
  String expireData;
  String cvv;
  String cardHolderName;

  CreditCardModel({
    this.cardHolderName,
    this.cvv,
    this.expireData,
    this.number
  });

}
