import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infrastructure/flutter/components/Background.dart';
import 'package:infrastructure/flutter/components/HomeBottomNavigationBar.dart';
import 'dart:developer' as dev;

import 'package:mopei_app/src/ui/login/LoginModal.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Background(
      title: "Mopei",
      showDrawer: true,
      bottomNavigation: HomeBottomNavigationBar(),
      actions: [
        AppBarAction(
          imgPath: "assets/img/icNotification.png",
          onTap: () => LoginModal(context).show(),
        )
      ],
      child: Container(
        child: Center(
          child: Hero(
            tag: "title",
            child: Text("TESTE",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          )
        ),
      )
    );
  }


}


