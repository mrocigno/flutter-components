import 'dart:developer' as dev;
import 'package:data/local/entity/Cart.dart';
import 'package:data/local/entity/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/backgrounds/Background.dart';
import 'package:infrastructure/flutter/components/buttons/BumpButton.dart';
import 'package:infrastructure/flutter/components/buttons/FavoriteButton.dart';
import 'package:infrastructure/flutter/components/buttons/MopeiButton.dart';
import 'package:infrastructure/flutter/components/containers/BackgroundContainer.dart';
import 'package:infrastructure/flutter/components/textviews/Amount.dart';
import 'package:infrastructure/flutter/components/textviews/Hyperlink.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/routing/ScreenTransitions.dart';
import 'package:mopei_app/src/ui/cards/CardCartProduct.dart';
import 'package:mopei_app/src/ui/details/ProductDetails.dart';
import 'package:mopei_app/src/ui/main/cart/CartBloc.dart';
import 'package:mopei_app/src/ui/main/home/HomeBloc.dart';
import 'package:mopei_app/src/ui/main/navigation/MainNavigationBloc.dart';
import 'package:mopei_app/src/ui/search/SearchScreen.dart';

class CartScreen extends StatelessWidget  {

  final CartBloc bloc = inject();
  final MainNavigationBloc navigationBloc = sharedBloc();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.getProducts();
    });

    Widget emptyCart = Container(
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
                  theme: MopeiButtonTheme.outlined,
                  text: Strings.strings["go_to_shop"],
                  onTap: () => ScreenTransitions.push(context, SearchScreen(), animation: Animations.FADE),
                )
            ),
          )
        ],
      ),
    );

    return BackgroundContainer(
      theme: BackgroundContainerTheme.FLAT,
      child: StreamBuilder<List<Product>>(
        stream: bloc.products,
        builder: (context, snapshot) {
          if(!snapshot.hasData || snapshot.data.length <= 0) return emptyCart;
          return SingleChildScrollView(
            padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                ListView.builder(
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CardCartProduct(
                      model: snapshot.data[index],
                      onCardClick: (product) async {
                        await ScreenTransitions.push(context, ProductDetails(
                          model: product,
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
                    theme: MopeiButtonTheme.outlined,
                    text: Strings.strings["receive_in_home"],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: MopeiButton(
                      theme: MopeiButtonTheme.mainTheme,
                      text: Strings.strings["schedule_exchange"],
                    )
                )
              ],
            ),
          );
        },
      ),
    );
  }
}