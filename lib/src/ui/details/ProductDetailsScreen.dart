import 'dart:developer' as dev;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:data/local/entity/Cart.dart';
import 'package:data/local/entity/Favorite.dart';
import 'package:data/local/entity/Photo.dart';
import 'package:flutter/services.dart';
import 'package:infrastructure/flutter/base/BaseScreen.dart';
import 'package:infrastructure/flutter/components/backgrounds/BackgroundSliver.dart';
import 'package:infrastructure/flutter/components/buttons/FavoriteButton.dart';
import 'package:infrastructure/flutter/components/buttons/MopeiButton.dart';
import 'package:infrastructure/flutter/components/carousel/Carousel.dart';
import 'package:infrastructure/flutter/components/containers/BottomScaffoldContainer.dart';
import 'package:infrastructure/flutter/components/image/ImagePlaceholder.dart';
import 'package:infrastructure/flutter/components/textviews/Amount.dart';
import 'package:infrastructure/flutter/components/textviews/Hyperlink.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:data/local/entity/Product.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/routing/AppRoute.dart';
import 'package:mopei_app/src/ui/details/ProductDetailsBloc.dart';
import 'package:mopei_app/src/ui/main/navigation/MainNavigationBloc.dart';
import 'package:rxdart/rxdart.dart';

class ProductDetailsScreen extends BaseScreen with RouteObserverMixin {

  final int productId;
  final ProductDetailsBloc detailsBloc = bloc();
  final MainNavigationBloc navigationBloc = sharedBloc();

  ProductDetailsScreen({
    this.productId,
  });

  @override
  String get name => "ProductDetails";

  void addToCart(){
//    detailsBloc.addToCart(model);
  }

  void removeFromCart(){
    detailsBloc.removeFromCart();
  }

  @override
  void initState() {
    super.initState();
    detailsBloc.getProduct(productId);
  }

  @override
  void dispose() {
    super.dispose();
    detailsBloc.close();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Stack(
      children: <Widget>[
        StreamBuilder(
          stream: detailsBloc.product.empty,
          builder: (context, snapshot) {
            return Text("Eita");
          },
        ),
        StreamBuilder<Product>(
          stream: detailsBloc.product.success,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Wrap();
            Product model = snapshot.data;

            bool inCart = model.cart != null;
            bool inFavorite = model.favorite != null;

            return BackgroundSliver(
              expandedHeight: 300,
              bottomNavigation: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                constraints: inCart? BoxConstraints(maxHeight: 200) : BoxConstraints(maxHeight: 0),
                transform: Matrix4.translationValues(0, inCart? 0 : 200, 0),
                child: BottomScaffoldContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Hyperlink(Strings.strings["keep_buying"],
                            style: TextStyles.poppinsMedium,
                            wrapAlignment: WrapAlignment.center,
                            onPress: () => Navigator.pop(context),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MopeiButton(
                            text: Strings.strings["see_cart"],
                            theme: MopeiButtonTheme.outlined,
                            onTap: () {
                              navigationBloc.setPage(1);
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              flexibleSpaceBar: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Stack(
                    children: <Widget>[
                      StreamBuilder<bool>(
                        stream: Rx.combineLatest2(detailsBloc.photos.loading, detailsBloc.photos.empty, (loading, empty) {
                          return (loading || empty);
                        }).shareValue(),
                        initialData: true,
                        builder: (context, snapshot) {
                          if (!snapshot.data) return Wrap();
                          return CachedNetworkImage(
                            placeholder: (context, url) => ImagePlaceholder(),
                            imageUrl: model.mainImageUrl,
                            alignment: Alignment.center,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      StreamBuilder<List<Photo>>(
                        stream: detailsBloc.photos.success,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return Wrap();
                          var list = snapshot.data;
                          return Carousel(
                            itemCount: list.length,
                            enableInfiniteScroll: list.length > 1,
                            itemBuilder: (context, index) => CachedNetworkImage(
                              placeholder: (context, url) => ImagePlaceholder(),
                              imageUrl: list[index].path,
                              alignment: Alignment.center,
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ],
                  )
              ),
              child: SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(model?.provider ?? "", style: TextStyles.poppinsMedium),
                                Text(model?.name ?? "", style: TextStyles.titleBlack),
                              ],
                            ),
                          ),
                          Hero(
                              tag: "favoriteStar ${model?.id}",
                              child: Container(
                                child: Material(
                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                  elevation: 3,
                                  child: FavoriteButton(
                                    active: inFavorite,
                                    onPressed: (active) {
                                      if (active) detailsBloc.addToFavorite();
                                      else detailsBloc.removeFromFavorite();
                                    },
                                  ),
                                ),
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
                              child: MopeiButton(
                                text: Strings.strings[inCart? "added" : "buy"],
                                onTap: () {
                                  if(!inCart) detailsBloc.addToCart();
                                  else detailsBloc.removeFromCart();
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

}