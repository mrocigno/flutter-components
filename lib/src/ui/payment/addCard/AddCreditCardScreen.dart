/*
* Created to flutter-components at 05/17/2020
*/
import "dart:developer" as dev;

import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/base/BaseScreen.dart';
import 'package:infrastructure/flutter/components/backgrounds/Background.dart';
import 'package:infrastructure/flutter/components/buttons/MopeiButton.dart';
import 'package:infrastructure/flutter/components/containers/BackgroundContainer.dart';
import 'package:infrastructure/flutter/components/containers/BottomScaffoldContainer.dart';
import 'package:infrastructure/flutter/components/containers/CreditCardForm.dart';
import 'package:infrastructure/flutter/components/inputs/FormValidate.dart';
import 'package:infrastructure/flutter/components/inputs/InputController.dart';
import 'package:infrastructure/flutter/components/inputs/InputText.dart';
import 'package:infrastructure/flutter/routing/AppRoute.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;

class AddCreditCardScreen extends BaseScreen {

  @override
  String get name => "AddCreditCard";

  @override
  Widget build(BuildContext context) {

    return Background(
        bottomNavigation: BottomScaffoldContainer(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: MopeiButton(
                    theme: MopeiButtonTheme.outlined,
                    text: "Cancelar",
                  ),
                ),
                Container(width: 10, height: 1,),
                Expanded(
                  flex: 1,
                  child: MopeiButton(
                    theme: MopeiButtonTheme.mainTheme,
                    text: "Adicionar",
                  ),
                )
              ],
            ),
          ),
        ),
        child: BackgroundContainer(
          theme: BackgroundContainerTheme.FLAT,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: CreditCardForm(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

}
