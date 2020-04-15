import 'dart:developer' as dev;
import 'package:flutter/services.dart';
import 'package:infrastructure/flutter/components/backgrounds/BackgroundSliver.dart';
import 'package:infrastructure/flutter/components/backgrounds/BackgroundThemes.dart';
import 'package:infrastructure/flutter/components/buttons/FavoriteButton.dart';
import 'package:infrastructure/flutter/components/buttons/MopeiButton.dart';
import 'package:infrastructure/flutter/components/containers/BottomScaffoldContainer.dart';
import 'package:infrastructure/flutter/components/textviews/Amount.dart';
import 'package:infrastructure/flutter/components/textviews/Hyperlink.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:data/entity/Product.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/backgrounds/Background.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:mopei_app/src/di/Injection.dart';
import 'package:mopei_app/src/ui/details/ProductDetailsBloc.dart';

class ProductDetails extends StatelessWidget {

  final Product model;
  final ProductDetailsBloc bloc = Injection.inject();

  ProductDetails({
    this.model,
  });

  void addToCart(){
    bloc.updateCart(model);
  }

  void removeFromCart(){
    bloc.updateCart(model);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundSliver(
      expandedHeight: 300,
      bottomNavigation: StreamBuilder(
        stream: bloc.onCart,
        initialData: model.favorite,
        builder: (context, snapshot) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            constraints: snapshot.data? BoxConstraints(maxHeight: 200) : BoxConstraints(maxHeight: 0),
            transform: Matrix4.translationValues(0, snapshot.data? 0 : 200, 0),
            child: BottomScaffoldContainer(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Hyperlink(Strings.strings["keep_buying"],
                        theme: HyperlinkTheme.poppinsMedium,
                        wrapAlignment: WrapAlignment.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MopeiButton(
                        text: Strings.strings["see_cart"],
                        theme: MopeiButtonTheme.outlined,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      flexibleSpaceBar: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Image.network(model?.mainImageUrl ?? "",
            alignment: Alignment.center,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          )
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(model?.provider ?? "", style: TextStyles.poppinsMedium),
                    Text(model?.name ?? "", style: TextStyles.productTitle),
                  ],
                ),
                Hero(
                  tag: "favoriteStar ${model?.localId}",
                  child: StreamBuilder<bool>(
                    stream: bloc.favorite,
                    initialData: model.favorite,
                    builder: (context, snapshot) {
                      return Container(
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          elevation: 3,
                          child: FavoriteButton(
                            active: snapshot.data,
                            onPressed: (active) {
                              model.favorite = active;
                              bloc.updateFavorite(model);
                            },
                          ),
                        ),
                      );
                    },
                  )
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(model?.description ?? "", style: TextStyles.poppinsMedium),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Amount(amount: model?.value ?? 0),
                  ),
                  Expanded(
                    flex: 1,
                    child: StreamBuilder(
                      stream: bloc.onCart,
                      initialData: model.favorite,
                      builder: (context, snapshot) {
                        return MopeiButton(
                          text: Strings.strings[snapshot.data? "added" : "buy"],
                          onTap: snapshot.data? addToCart : removeFromCart,
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }



}