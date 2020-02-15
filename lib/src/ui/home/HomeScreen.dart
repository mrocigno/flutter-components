import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/Background.dart';
import 'package:infrastructure/flutter/components/Input.dart';
import 'package:infrastructure/flutter/components/Hyperlink.dart';
import 'package:infrastructure/flutter/components/MopeiButton.dart';
import 'dart:developer' as dev;

import 'package:mopei_app/src/ui/splash/SplashScreen.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Background(
      title: "Mopei",
      showDrawer: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
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
              onTap: () => dev.log("asdasdasd")
            )
          ],
        ),
      )
    );
  }


}
