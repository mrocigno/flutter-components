import 'package:data/local/entity/Product.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/animations/AnimatedStar.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/components/carousel/TabView.dart';
import 'package:infrastructure/flutter/components/textviews/Hyperlink.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/routing/ScreenTransitions.dart';
import 'package:infrastructure/flutter/utils/Functions.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:mopei_app/src/ui/cards/CardProduct.dart';
import 'package:mopei_app/src/ui/details/ProductDetails.dart';
import 'package:mopei_app/src/ui/login/LoginModal.dart';
import 'package:mopei_app/src/ui/main/home/HomeBloc.dart';

class PageFavorites extends TabChild {

  @override
  String get title => Strings.strings["home_page_3"];

  @override
  StatelessWidget get child => _PageFavorites();

}

class _PageFavorites extends StatelessWidget {

  final HomeBloc bloc = sharedBloc();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        StreamBuilder(
          stream: bloc.favorites.loading,
          initialData: false,
          builder: (context, snapshot) => snapshot.data? (
              RefreshProgressIndicator()
          ) : Wrap(),
        ),
        StreamBuilder(
          stream: bloc.favorites.empty,
          initialData: false,
          builder: (context, snapshot) {
            if(!snapshot.data) return Wrap();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AnimatedStar(autoStart: true),
                Text(Strings.strings["not_favored"], style: TextStyles.subtitleBlack)
              ],
            );
          },
        ),
        StreamBuilder<Exception>(
          stream: bloc.favorites.error,
          builder: (context, snapshot) {
            if(snapshot.data == null) return Wrap();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AnimatedStar(autoStart: true),
                Text(Strings.strings["not_favored"], style: TextStyles.subtitleBlack),
                Hyperlink("Já tem uma conta?", onPress: () => showLogin(context))
              ],
            );
          },
        ),
        StreamBuilder<List<Product>>(
          stream: bloc.favorites.success,
          builder: (context, snapshot) {
            if(snapshot.data == null) return Wrap();
            return ListView.builder(
              padding: EdgeInsets.only(left: 20),
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                var model = snapshot.data[index];
                return CardProduct(
                  hideWhenDisfavor: true,
                  model: model,
                  onCardClick: (product) => ScreenTransitions.push(context, ProductDetails(
                    model: product,
                  )),
                  onFavoriteButtonPressed: (favorite, active) async {
                    bloc.removeFromFavorite(favorite);
                    model.favorite = null;
                  },
                  onHideAnimationEnd: () => bloc.getFavorites(),
                );
              },
            );
          },
        )
      ],
    );
  }

  showLogin(BuildContext context) {
    LoginModal(context, onSuccess: () {
      bloc.getFavorites();
    }).show();
  }


}