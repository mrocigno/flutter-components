/*
* Created to flutter-components at 05/09/2020
*/
import "dart:developer" as dev;

import 'package:flutter/cupertino.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/inputs/InputText.dart';

class CustomFlexible extends StatefulWidget {

  @override
  CustomFlexibleState createState() => CustomFlexibleState();
}

class CustomFlexibleState extends State<CustomFlexible> {

  @override
  Widget build(BuildContext context) {
    final FlexibleSpaceBarSettings settings = context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();

    final double deltaExtent = settings.maxExtent - settings.minExtent;

    // 1.0 -> Expanded
    // 0.0 -> Collapsed to toolbar
    final double t = (1 -(settings.currentExtent - settings.minExtent) / deltaExtent).clamp(0.0, 1.0) as double;

    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: (1 - t),
            child: Container(
              alignment: Alignment.center,
              height: 56,
              child: Text("Mopei", style: TextStyle(fontSize: 20, color: Constants.Colors.PRIMARY_SWATCH),),
            )
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(left: (50 * t), right: (50 * t)),
            child: Hero(
              tag: "SearchField",
              child: Material(
                color: Colors.transparent,
                child: Input(InputThemes.searchTheme,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  icon: "assets/img/icSearchWhite.png",
                  onTapIcon: (){
                    dev.log("masue");
                  },
                ),
              ),
            ),
          )
        ],
      )
    );
  }

}