/*
* Created to flutter-components at 05/17/2020
*/
import "dart:developer" as dev;

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_useful_things/components/backgrounds/Background.dart';
import 'package:flutter_useful_things/components/buttons/BumpButton.dart';
import 'package:flutter_useful_things/components/inputs/FormValidate.dart';
import 'package:flutter_useful_things/components/inputs/InputController.dart';
import 'package:flutter_useful_things/components/inputs/InputText.dart';
import 'package:flutter_useful_things/utils/Functions.dart';
import 'package:core/constants/Colors.dart' as Constants;

class CreditCardForm extends StatefulWidget {

  CreditCardForm({Key key}) : super(key: key);
  
  @override
  CreditCardFormState createState() => CreditCardFormState();

}

class CreditCardFormState extends State<CreditCardForm> with SingleTickerProviderStateMixin {

  FocusNode _cvvFocus = FocusNode();
  var _cvvHasFocus = false;
  var _oldCvvStatus = false;
  AnimationController _controller;
  GlobalKey<FormValidateState> _formValidateKey;

  InputController _numCardController = InputController(
    mask: "#### #### #### ####",
    validateBuild: (wrapper) {
      wrapper.minLength(19, "Número inválido");
      wrapper.isCreditCard("Número inválido");
      wrapper.required("Informe o número do cartão");
    },
  );
  InputController _expireDateController = InputController(
    mask: "##/##",
    validateBuild: (wrapper) {
      wrapper.customValidate("Data invalida", (text) {
        var list = text.split("/");
        if(list.length > 1){
          var now = DateTime.now();
          var expireDate = DateTime.parse("20${list[1]}-${list[0]}-28");
          return expireDate.isAfter(now);
        }
        return false;
      });
      wrapper.required("Informe a data");
    },
  );
  InputController _cvvController = InputController(
    mask: "###",
    validateBuild: (wrapper) {
      wrapper.minLength(3, "Cvv inválido");
      wrapper.required("Inform o cvv");
    },
  );
  InputController _nameController = InputController(
    validateBuild: (wrapper) {
      wrapper.twoOrMore("Informe nome e sobrenome");
      wrapper.required("Informe o nome do proprietário");
    },
  );

  @override
  void initState() {
    super.initState();
    _formValidateKey = GlobalKey();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _cvvFocus.addListener(() => setState(() {
      _cvvHasFocus = !_cvvHasFocus;
    }));

    _numCardController.addListener(() => setState((){}));
    _expireDateController.addListener(() => setState((){}));
    _cvvController.addListener(() => setState((){}));
    _nameController.addListener(() => setState((){}));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _numCardController.dispose();
    _expireDateController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
  }
  
  bool validate() => _formValidateKey.currentState.validate();
  
  String getNumCard() => _numCardController.text.trim();
  String getExpireDate() => _expireDateController.text.trim();
  String getCvv() => _cvvController.text.trim();
  String getName() => _nameController.text.trim();

  @override
  Widget build(BuildContext context) {

    Animation<double> animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: .7), weight: 1.0),
      TweenSequenceItem(tween: Tween(begin: .7, end: 1.0), weight: 1.0),
    ]).animate(_controller);

    if(_oldCvvStatus != _cvvHasFocus){
      _controller.forward().then((value) => _controller.reset());
      _oldCvvStatus = _cvvHasFocus;
    }

    var dateValue = _expireDateController.isEmpty()? "mm/aa" : _expireDateController.text;
    var nameValue = _nameController.isEmpty()? "Nome" : _nameController.text;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 2,
            child: Container(
              width: 300,
              height: 170,
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
                          cardNumber: _numCardController.text,
                          expiryDate: dateValue,
                          cardHolderName: nameValue,
                          cvvCode: _cvvController.text,
                          cardbgColor: Constants.Colors.PRIMARY_SWATCH,
                          showBackView: _cvvHasFocus,
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
          key: _formValidateKey,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Constants.Colors.BACKGROUND_MARBLE_MEDIUM
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Input(InputThemes.loginTheme,
                controller: _numCardController,
                margin: const EdgeInsets.symmetric(vertical: 20),
                hint: "Número do cartão",
                keyboardType: TextInputType.number,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Input(InputThemes.loginTheme,
                        controller: _expireDateController,
                        margin: const EdgeInsets.only(bottom: 20, right: 10),
                        hint: "Data de validade",
                        keyboardType: TextInputType.number,
                      )
                  ),
                  Expanded(
                    flex: 1,
                    child: Input(InputThemes.loginTheme,
                      controller: _cvvController,
                      margin: const EdgeInsets.only(bottom: 20, left: 10),
                      hint: "CVV",
                      focusNode: _cvvFocus,
                      keyboardType: TextInputType.number,
                    ),
                  )
                ],
              ),
              Input(InputThemes.loginTheme,
                controller: _nameController,
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
