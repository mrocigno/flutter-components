/*
* Created to flutter-components at 05/17/2020
*/
import "dart:developer" as dev;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;

class CarouselWithIndicator extends StatefulWidget {

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final bool enableInfiniteScroll;

  CarouselWithIndicator({
    @required this.itemCount,
    @required this.itemBuilder,
    this.enableInfiniteScroll = true
  });

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();

}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        CarouselSlider.builder(
          itemCount: widget.itemCount,
          options: CarouselOptions(
            height: double.infinity,
            initialPage: _page,
            enableInfiniteScroll: widget.enableInfiniteScroll,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) => setState(() => _page = index),
          ),
          itemBuilder: widget.itemBuilder
        ),
        (widget.itemCount > 1? (
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
