import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:flutter/services.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double iconSize = 24.0;
    return BottomNavigationBar(
      showSelectedLabels: false,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Constants.Colors.BOTTOM_NAVIGATION_BAR_COLOR,
          icon: Image.asset("assets/img/icHome.png", width: iconSize, height: iconSize,),
          activeIcon: Image.asset("assets/img/icHomeActive.png", width: iconSize, height: iconSize,),
          title: Text("Home")
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/img/icCart.png", width: iconSize, height: iconSize,),
          activeIcon: Image.asset("assets/img/icCartActive.png", width: iconSize, height: iconSize,),
          title: Text("Carrinho")
        ),
//        BottomNavigationBarItem(
//          icon: Image.asset("assets/img/icBitcoin.png", width: iconSize, height: iconSize,),
//          activeIcon: Image.asset("assets/img/icBitcoinActive.png", width: iconSize, height: iconSize,),
//          title: Text("Bitcoin")
//        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/img/icHelp.png", width: iconSize, height: iconSize,),
          activeIcon: Image.asset("assets/img/icHelpActive.png", width: iconSize, height: iconSize,),
          title: Text("Ajuda")
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/img/icUser.png", width: iconSize, height: iconSize,),
          activeIcon: Image.asset("assets/img/icUserActive.png", width: iconSize, height: iconSize,),
          title: Text("Perfil")
        ),
      ],
    );
  }


}