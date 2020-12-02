/*
* Created to flutter-components at 05/17/2020
*/
import "dart:developer" as dev;

import 'package:core/theme/CoreButtonTheme.dart';
import 'package:data/local/entity/CreditCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_useful_things/base/BaseScreen.dart';
import 'package:flutter_useful_things/components/backgrounds/Background.dart';
import 'package:flutter_useful_things/components/buttons/MopeiButton.dart';
import 'package:flutter_useful_things/components/containers/BackgroundContainer.dart';
import 'package:flutter_useful_things/components/containers/BottomScaffoldContainer.dart';
import 'package:flutter_useful_things/components/containers/CreditCardForm.dart';
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:flutter_useful_things/routing/AppRoute.dart';
import 'package:core/constants/Colors.dart' as Constants;
import 'package:flutter_useful_things/utils/Functions.dart';
import 'package:mopei_app/src/ui/payment/addCard/AddCreditCardBloc.dart';

class AddCreditCardScreen extends BaseScreen {

  @override
  String get name => "AddCreditCard";
  final AddCreditCardBloc _bloc = bloc();

  GlobalKey<CreditCardFormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _bloc.card.observeSuccess((data) {
      Navigator.pop(context);
    });
  }

  @override
  Widget buildScreen(BuildContext context) {

    return Background(
        bottomNavigation: BottomScaffoldContainer(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StreamBuilder<bool>(
                  stream: _bloc.card.loading,
                  initialData: false,
                  builder: (context, snapshot) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: (snapshot.data? 0 : widthByPercent(context, 45)),
                      margin: EdgeInsets.only(right: snapshot.data? 0 : 10),
                      child: MopeiButton(
                        theme: CoreButtonTheme.outlined,
                        text: "Cancelar",
                        onTap: () => Navigator.pop(context),
                      ),
                    );
                  },
                ),
                Expanded(
                  flex: 1,
                  child: MopeiButton(
                    theme: CoreButtonTheme.mainTheme,
                    text: "Adicionar",
                    isLoading: _bloc.card.loading,
                    onTap: () {
                      hideKeyboard(context);
                      if(_formKey.currentState.validate()){
                        _bloc.addCreditCard(CreditCard(
                          isDefault: false,
                          entityFlag: "MASTER",
                          cardHolderName: _formKey.currentState.getName(),
                          isRemoved: false,
                          placeHolder: _formKey.currentState.getNumCard(),
                        ));
                      }
                    },
                  ),
                ),
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
                        child: CreditCardForm(
                          key: _formKey,
                        ),
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
