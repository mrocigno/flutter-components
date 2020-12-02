import 'dart:developer' as dev;
import 'package:core/theme/CoreButtonTheme.dart';
import 'package:data/local/entity/Cart.dart';
import 'package:data/local/entity/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_useful_things/components/backgrounds/Background.dart';
import 'package:flutter_useful_things/components/buttons/BumpButton.dart';
import 'package:flutter_useful_things/components/buttons/FavoriteButton.dart';
import 'package:flutter_useful_things/components/buttons/MopeiButton.dart';
import 'package:flutter_useful_things/components/containers/BackgroundContainer.dart';

import 'package:flutter_useful_things/components/textviews/Hyperlink.dart';
import 'package:flutter_useful_things/components/textviews/TextStyles.dart';
import 'package:core/constants/Colors.dart' as Constants;
import 'package:core/constants/Strings.dart';
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:flutter_useful_things/routing/ScreenTransitions.dart';
import 'package:mopei_app/src/ui/cards/CardCartProduct.dart';
import 'package:mopei_app/src/ui/details/ProductDetailsScreen.dart';
import 'package:mopei_app/src/ui/main/cart/CartBloc.dart';
import 'package:mopei_app/src/ui/main/home/HomeBloc.dart';
import 'package:mopei_app/src/ui/main/navigation/MainNavigationBloc.dart';
import 'package:mopei_app/src/ui/search/SearchScreen.dart';

class CartScreen extends StatefulWidget  {

  _CartScreenState createState() => _CartScreenState();

}

class _CartScreenState extends State<CartScreen> {

  final CartBloc bloc = inject();
  final MainNavigationBloc navigationBloc = sharedBloc();

  @override
  void initState() {
    super.initState();
    bloc.getProducts();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(milliseconds: 300);

    return BackgroundContainer(
        theme: BackgroundContainerTheme.FLAT,
        child: Stack(
          children: <Widget>[
            StreamBuilder(
              stream: bloc.products.empty,
              initialData: false,
              builder: (context, snapshot) {
                bool show = snapshot.data;
                return AnimatedOpacity(
                  duration: duration,
                  opacity: show? 1 : 0,
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: <Widget>[
                        Image.asset("assets/img/icSadFace.webp", width: 200, height: 200),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Constants.Colors.COLOR_PRIMARY.withOpacity(.8),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Text(Strings.strings["nothing_in_cart"], style: TextStyles.subtitleWhite, textAlign: TextAlign.center),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              padding: const EdgeInsets.all(20),
                              child: MopeiButton(
                                theme: CoreButtonTheme.outlined,
                                text: Strings.strings["go_to_shop"],
                                onTap: () => ScreenTransitions.push(context, SearchScreen(), animation: Animations.FADE),
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            StreamBuilder<List<Product>>(
              stream: bloc.products.success,
              builder: (context, snapshot) {
                bool show = snapshot.data != null;

                return AnimatedOpacity(
                  duration: duration,
                  opacity: show? 1 : 0,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CardCartProduct(
                              model: snapshot.data[index],
                              onCardClick: (product) async {
                                await ScreenTransitions.push(context, ProductDetailsScreen(
                                  productId: product.id,
                                ));
                                bloc.getProducts();
                              },
                              onChangeAmount: (cart) {
                                bloc.save(cart);
                                bloc.calculateTotal();
                              },
                              onClickRemoveButton: (cart) {
                                bloc.removeFromCart(cart);
                                navigationBloc.checkCart();
                              },
                              onHideAnimationEnd: () => bloc.getProducts(),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 20,
                            children: <Widget>[
                              Text(Strings.strings["sub_total"], style: TextStyles.subtitleBlackBold),
                              StreamBuilder<double>(
                                stream: bloc.total,
                                initialData: 0,
                                builder: (context, snapshot) {
                                  return Text(Strings.toMonetary(snapshot.data), style: TextStyles.subtitleBlack);
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          alignment: Alignment.center,
                          child: Hyperlink(Strings.strings["keep_buying"],
                            style: TextStyles.subtitleBlack,
                            onPress: () => ScreenTransitions.push(context, SearchScreen(), animation: Animations.FADE),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          alignment: Alignment.center,
                          child: MopeiButton(
                            theme: CoreButtonTheme.outlined,
                            text: Strings.strings["receive_in_home"],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            alignment: Alignment.center,
                            child: MopeiButton(
                              theme: CoreButtonTheme.mainTheme,
                              text: Strings.strings["schedule_exchange"],
                            )
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        )
    );
  }

}