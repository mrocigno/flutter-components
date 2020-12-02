/*
* Created to flutter-components at 05/17/2020
*/
import "dart:developer" as dev;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:core/constants/Colors.dart' as Constants;

class Carousel extends StatefulWidget {

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final bool enableInfiniteScroll;
  final bool showIndicator;
  final Axis direction;
  final double viewPort;
  final Function(int index, CarouselPageChangedReason reason) onPageChanged;

  Carousel({
    Key key,
    @required this.itemCount,
    @required this.itemBuilder,
    this.enableInfiniteScroll = true,
    this.showIndicator = true,
    this.direction = Axis.horizontal,
    this.viewPort = 1.0,
    this.onPageChanged
  }) : super(key: key);

  @override
  CarouselState createState() => CarouselState();

}

class CarouselState extends State<Carousel> {

  int _page;
  int get page => _page;

  @override
  void initState() {
    super.initState();
    _page = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        (widget.itemCount > 0? (
          CarouselSlider.builder(
            itemCount: widget.itemCount,
            options: CarouselOptions(
              height: double.infinity,
              initialPage: _page,
              enableInfiniteScroll: widget.enableInfiniteScroll,
              viewportFraction: widget.viewPort,
              scrollDirection: widget.direction,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() => _page = index);
                widget.onPageChanged?.call(index, reason);
              },
            ),
            itemBuilder: widget.itemBuilder
          )
        ) : Wrap()),
        (widget.showIndicator && widget.itemCount > 1? (
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              spacing: 7,
              children: List.generate(widget.itemCount, (index) {
                return Container(
                  height: index == _page? 3 : 3,
                  width: index == _page? 20 : 15,
                  decoration: BoxDecoration(
                    color: index == _page? Constants.Colors.PRIMARY_SWATCH : Colors.blueGrey,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                );
              })
            ),
          )
        ) : Wrap())
      ],
    );
  }

}
