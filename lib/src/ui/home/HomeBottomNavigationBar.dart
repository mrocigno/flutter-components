import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:flutter/services.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double iconSize = 24.0;

    return Material(
      color: Constants.Colors.BACKGROUND_WHITE,
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: BottomNavigationBar(
          elevation: 0,
          showSelectedLabels: false,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Image.asset("assets/img/icHome.png", width: iconSize, height: iconSize,),
                activeIcon: Image.asset("assets/img/icHomeActive.png", width: iconSize, height: iconSize,),
                title: Text("Home")
            ),
            BottomNavigationBarItem(
              icon: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset("assets/img/icCart.png", width: iconSize, height: iconSize,),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    transform: Matrix4.translationValues(5, -5, 0),
                  )
                ],
              ),
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
        ),
      ),
    );
  }
}