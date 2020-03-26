import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/Background.dart';
import 'package:infrastructure/flutter/components/inputs/InputController.dart';
import 'package:infrastructure/flutter/components/inputs/InputText.dart';
import 'package:infrastructure/flutter/components/Hyperlink.dart';
import 'package:infrastructure/flutter/components/MopeiButton.dart';
import 'package:mopei_app/src/ui/login/LoginModal.dart';
import 'dart:developer' as dev;

import 'package:mopei_app/src/ui/splash/SplashScreen.dart';


// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {

  InputController teste = InputController(
//    validateBuild: (wrapper) {
//      wrapper.minLength(10, "Minimo de 10 caracteres");
//      wrapper.required("Campo obrigatório");
//    },
  );

  @override
  Widget build(BuildContext context) {
    return Background(
      title: "Mopei",
      showDrawer: true,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  width: 100,
                  child: Input(InputThemes.searchTheme,
                    icon: "assets/icSearchPurple.png",
                    hint: "Hint",
                    controller: teste,
                    onTapIcon: () {dev.log("teste");},
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: Hyperlink("aaa",
                  onPress: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen())),
                ),
              )
            ],
          ),
          MopeiButton(MopeiButtonTheme.mainTheme,
            onTap: () {
              LoginModal(context).show();
            }
          )
        ],
      )
    );
  }


}


