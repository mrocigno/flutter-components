/*
* Created to flutter-components at 05/20/2020
*/
import "dart:developer" as dev;
import 'dart:ui';


import 'package:data/entity/CreditCard.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/base/BaseScreen.dart';
import 'package:infrastructure/flutter/components/backgrounds/Background.dart';
import 'package:infrastructure/flutter/components/buttons/MopeiButton.dart';
import 'package:infrastructure/flutter/components/carousel/CarouselWithIndicator.dart';
import 'package:infrastructure/flutter/components/containers/BackgroundContainer.dart';
import 'package:infrastructure/flutter/components/containers/BottomScaffoldContainer.dart';
import 'package:infrastructure/flutter/components/containers/CreditCardForm.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/routing/AppRoute.dart';
import 'package:infrastructure/flutter/routing/ScreenTransitions.dart';
import 'dart:math' as math;

import 'package:infrastructure/flutter/utils/Functions.dart';
import 'package:mopei_app/src/ui/payment/CardListBloc.dart';
import 'package:mopei_app/src/ui/payment/addCard/AddCreditCardScreen.dart';

class CardListScreen extends BaseScreen with RouteObserverMixin {

  @override
  String get name => "CardList";

  final CardListBloc cardBloc = bloc();

  @override
  void onCalled() {
    cardBloc.refreshCards();
  }

  @override
  Widget build(BuildContext context) {

    return Background(
      bottomNavigation: BottomScaffoldContainer(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: MopeiButton(text: "Adicionar novo cartão", onTap: () => ScreenTransitions.push(context, AddCreditCardScreen(), animation: Animations.FADE),),
        ),
      ),
      theme: BackgroundTheme.main,
      child: BackgroundContainer(
        theme: BackgroundContainerTheme.FLAT,
        child: Container(
          height: 340,
          child: StreamBuilder<List<CreditCard>>(
            stream: cardBloc.cards.success,
            builder: (context, snapshot) {
              if(!snapshot.hasData) return Wrap();
              if(snapshot.data.length <= 0) return Wrap();
              var list = snapshot.data;
              return Carousel(
                viewPort: .7,
                itemCount: list.length,
                direction: Axis.vertical,
                itemBuilder: (context, index) {
                  var model = list[index];
                  return Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      child: Material(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        elevation: 5,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              gradient: getGradient(index)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Image.asset("assets/img/icMcCard.webp", height: 50, width: 50,),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Wrap(
                                    direction: Axis.vertical,
                                    spacing: 10,
                                    children: <Widget>[
                                      Text(model.placeHolder, style: TextStyles.subtitleWhiteBold),
                                      Text(model.cardHolderName.toUpperCase(), style: TextStyles.bodyWhite)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                  );
                },
              );
            },
          )
        ),
      ),
    );
  }

  Gradient getGradient(int index) {
    var rand = math.Random(index + 255);
    var colorBegin = Constants.Colors.PRIMARY_SWATCH.withBlue(rand.nextInt(255));
    var colorEnd = Constants.Colors.PRIMARY_SWATCH.withBlue(rand.nextInt(255)).withOpacity(rand.nextDouble());

    return LinearGradient(
        colors: [
          colorBegin,
          colorEnd
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topCenter
    );
  }

}