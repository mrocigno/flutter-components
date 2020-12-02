import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/local/entity/Cart.dart';
import 'package:data/local/entity/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_useful_things/animations/FadeAnimation.dart';
import 'package:flutter_useful_things/components/buttons/BumpButton.dart';
import 'package:flutter_useful_things/components/image/ImagePlaceholder.dart';
import 'package:core/constants/Colors.dart' as Constants;
import 'package:flutter_useful_things/components/textviews/Amount.dart';
import 'package:flutter_useful_things/components/textviews/TextStyles.dart';
import 'package:core/constants/Strings.dart';
import 'package:mopei_app/src/ui/details/ProductDetailsScreen.dart';

class CardCartProduct extends StatefulWidget {

  final Product model;
  final Function onHideAnimationEnd;
  final OnChangeAmount onChangeAmount;
  final OnClickRemoveButton onClickRemoveButton;
  final OnCardClick onCardClick;

  CardCartProduct({
    @required this.model,
    this.onChangeAmount,
    this.onCardClick,
    this.onClickRemoveButton,
    this.onHideAnimationEnd
  });

  @override
  _CardCartProductState createState() => _CardCartProductState();

}

typedef OnChangeAmount = Function(Cart cart);
typedef OnClickRemoveButton = Function(Cart cart);
typedef OnCardClick = Function(Product product);

class _CardCartProductState extends State<CardCartProduct> {

  var animate = false;

  void plus() => setState(() {
    widget.model.cart.amount++;
    _callback(widget.model.cart);
  });

  void minus() => setState(() {
    if(widget.model.cart.amount != 1){
      widget.model.cart.amount--;
      _callback(widget.model.cart);
    }
  });

  void _callback(Cart cart) => widget.onChangeAmount?.call(cart);

  @override
  Widget build(BuildContext context) {

    var value = widget.model.value;
    var amount = widget.model.cart?.amount ?? 1;

    return FadeAnimation(
      animate: widget.model.cart == null,
      onEnd: widget.onHideAnimationEnd,
      duration: Duration(milliseconds: 300),
      child: Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: Material(
            color: Colors.white,
            elevation: 2,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                InkWell(
                  onTap: () => widget.onCardClick?.call(widget.model),
                  child: Container(
                    height: 150,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: CachedNetworkImage(
                              imageUrl: widget.model.mainImageUrl,
                              alignment: Alignment.center,
                              height: double.infinity,
                              width: double.infinity,
                              placeholder: (context, url) => ImagePlaceholder(),
                            )
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Container(
                                width: 1,
                                color: Constants.Colors.BLACK_TRANSPARENT_LOW,
                                margin: EdgeInsets.symmetric(vertical: 20),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.model.name, style: TextStyles.subtitleBlack),
                                      Amount(amount: value),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            BumpButton(
                                              icon: Icons.remove,
                                              activeColor: Colors.red,
                                              scale: 0,
                                              onPress: () {
                                                minus();
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                              child: Text("$amount", style: TextStyles.body),
                                            ),
                                            BumpButton(
                                              icon: Icons.add,
                                              activeColor: Colors.green,
                                              onPress: () {
                                                plus();
                                              },
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment: Alignment.bottomRight,
                                                child: Text("${Strings.toMonetary(value * amount)}", style: TextStyles.poppinsSmall,),
                                              ),
                                            )
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                BumpButton(
                  icon: Icons.delete,
                  scale: .8,
                  activeColor: Colors.red,
                  defBackgroundColor: Colors.transparent,
                  onPress: () => setState(() {
                    widget.onClickRemoveButton?.call(widget.model.cart);
                    widget.model.cart = null;
                  }),
                )
              ],
            )
        ),
      ),
    );
  }

}