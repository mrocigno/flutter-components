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
import 'package:infrastructure/flutter/components/carousel/Carousel.dart';
import 'package:infrastructure/flutter/components/containers/BackgroundContainer.dart';
import 'package:infrastructure/flutter/components/containers/BottomScaffoldContainer.dart';
import 'package:infrastructure/flutter/components/containers/CreditCardForm.dart';
import 'package:infrastructure/flutter/components/menu/ExpandableMenu.dart';
import 'package:infrastructure/flutter/components/textviews/CreditCardView.dart';
import 'package:infrastructure/flutter/components/textviews/EmptyState.dart';
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
  void onComeback() {
    cardBloc.refreshCards();
  }

  void goToAddCard(BuildContext context) {
    ScreenTransitions.push(context, AddCreditCardScreen(), animation: Animations.FADE);
  }

  final GlobalKey<CarouselState> _carouselKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Background(
      centerTitle: false,
      title: Text("Cartões cadastrados"),
      bottomNavigation: BottomScaffoldContainer(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: MopeiButton(
              isLoading: cardBloc.cards.loading,
              text: "Adicionar cartão",
              onTap: () => goToAddCard(context)
          ),
        ),
      ),
      theme: BackgroundTheme.main,
      child: Stack(
        children: <Widget>[
          StreamBuilder<bool>(
            stream: cardBloc.cards.empty,
            builder: (context, snapshot) {
              var show = snapshot.data ?? false;
              return AnimatedOpacity(
                opacity: show? 1 : 0,
                duration: Duration(milliseconds: 300),
                child: Container(
                    alignment: Alignment.center,
                    child: EmptyState(
                        icon: Icons.credit_card,
                        title: "Nenhum cartão cadastrado"
                    )
                ),
              );
            },
          ),
          StreamBuilder<List<CreditCard>>(
            stream: cardBloc.cards.success,
            builder: (context, snapshot) {
              var show = (snapshot.data?.length ?? 0) > 0;
              var list = snapshot.data;

              return AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: show? 1 : 0,
                alwaysIncludeSemantics: true,
                child: BackgroundContainer(
                    theme: BackgroundContainerTheme.FLAT,
                    child: Column(
                      children: <Widget>[
                        Container(
                            height: 340,
                            child: Carousel(
                              key: _carouselKey,
                              viewPort: .7,
                              itemCount: list?.length ?? 0,
                              enableInfiniteScroll: (list?.length ?? 0) > 1,
                              direction: Axis.vertical,
                              itemBuilder: (context, index) {
                                var model = list[index];
                                return Container(
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                    child: CreditCardView(
                                      bgGradient: getGradient(index),
                                      cardHolderName: model.placeHolder,
                                      cardNumber: model.cardHolderName,
                                      entityFlag: Image.asset("assets/img/icMcCard.webp", height: 50, width: 50),
                                    )
                                );
                              },
                            )
                        ),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Material(
                                color: Colors.white,
                                elevation: 2,
                                clipBehavior: Clip.hardEdge,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)
                                ),
                                child: Container(
                                  width: double.infinity,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        ExpandableMenu(
                                          backgroundColor: Constants.Colors.BACKGROUND_MARBLE,
                                          menus: [
                                            ExpandableMenuItem(
                                                initExpanded: true,
                                                arrowIcon: Icon(Icons.keyboard_arrow_down, size: 30),
                                                titleColor: Colors.black,
                                                title: "Ações",
                                                icon: Icon(Icons.build),
                                                items: [
                                                  ExpandableItem(
                                                      closeOnPress: false,
                                                      icon: Stack(
                                                        alignment: Alignment.topLeft,
                                                        children: <Widget>[
                                                          Icon(Icons.credit_card, size: 25),
                                                          Icon(Icons.flag, size: 15, color: Colors.green),
                                                        ],
                                                      ),
                                                      title: "Definir como padrão",
                                                      onPress: () => dev.log("${list[_carouselKey.currentState.page].id}")
                                                  ),
                                                  ExpandableItem(
                                                      closeOnPress: false,
                                                      icon: Stack(
                                                        alignment: Alignment.topRight,
                                                        children: <Widget>[
                                                          Icon(Icons.credit_card, size: 25),
                                                          Icon(Icons.edit, size: 15, color: Colors.amber),
                                                        ],
                                                      ),
                                                      title: "Editar dados",
                                                      onPress: () => dev.log("asdsd")
                                                  ),
                                                  ExpandableItem(
                                                      closeOnPress: false,
                                                      icon: Stack(
                                                        alignment: Alignment.center,
                                                        children: <Widget>[
                                                          Icon(Icons.credit_card, size: 25),
                                                          Icon(Icons.close, size: 30, color: Colors.red),
                                                        ],
                                                      ),
                                                      title: "Remover cartão",
                                                      onPress: () => dev.log("asdsd")
                                                  ),
                                                ]
                                            ),
                                          ],
                                        )

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                        )
                      ],
                    )
                ),
              );
            },
          ),
          StreamBuilder<bool>(
            stream: cardBloc.cards.loading,
            builder: (context, snapshot) {
              if (!snapshot.hasData || !snapshot.data) return Wrap();
              return Container(
                alignment: Alignment.topCenter,
                child: RefreshProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
  }

  Gradient getGradient(int index) {
    var rand = math.Random(index + 255);
    var value = 100 + rand.nextInt(255 - 100);
    var colorBegin = Constants.Colors.PRIMARY_SWATCH.withBlue(value);
    var colorEnd = Constants.Colors.PRIMARY_SWATCH.withBlue(value).withOpacity(rand.nextDouble());

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
