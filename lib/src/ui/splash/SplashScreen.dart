import 'dart:async';
import 'package:core/theme/CoreBackgroundTheme.dart';
import 'package:data/local/db/Config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_useful_things/animations/ChainAnimations.dart';
import 'package:flutter_useful_things/base/BaseScreen.dart';
import 'package:flutter_useful_things/components/backgrounds/Background.dart';
import 'package:flutter_useful_things/constants/Numbers.dart';
import 'package:core/constants/Strings.dart';
import 'package:flutter_useful_things/routing/ScreenTransitions.dart';
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:mopei_app/src/ui/main/MainScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  final StreamController<bool> startAnimate = StreamController();

  final GlobalKey _logoKey = GlobalKey();
  final GlobalKey _titleKey = GlobalKey();

  void toHome() {
    ScreenTransitions.pushReplacement(context, MainScreen());
  }

  double calculateTitlePosition(){
    RenderBox renderTitle = _titleKey.currentContext.findRenderObject();
    Offset positionTitle = renderTitle.localToGlobal(Offset.zero);

    RenderBox renderAnimated = _logoKey.currentContext.findRenderObject();
    Offset positionAnimated = renderAnimated.localToGlobal(Offset.zero);
    return positionTitle.dy - positionAnimated.dy;
  }

  AnimationController _translateYController;
  Animation<double> _translateY;
  AnimationController _opacityController;
  Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _opacityController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700)
    );
    _translateYController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500)
    );
  }

  @override
  Widget build(BuildContext context) {
    Strings.initialize().then((value) {
      _opacity = Tween(begin: 0.0, end: 1.0).animate(_opacityController);
      _opacityController.forward().then((value) {
        _translateY = Tween(begin: 0.0, end: calculateTitlePosition()).animate(
          CurvedAnimation(
            parent: _translateYController,
            curve: Curves.fastOutSlowIn
          )
        );
        _translateYController.forward().then((value) {
          toHome();
        });
      });
    });

    Config.open();

    return Background(
      theme: CoreBackgroundTheme.main,
      appBarConfig: AppBarConfig(
        title: Container(height: LOGO_HEIGHT, width: LOGO_WIDTH, key: _titleKey)
      ),
      child: AnimatedBuilder(
        animation: _translateYController,
        builder: (context, child) {
          return Center(
            child: Container(
              key: _logoKey,
              height: LOGO_HEIGHT, width: LOGO_WIDTH,
              transform: Matrix4.translationValues(0, _translateY?.value ?? 0, 0),
              child: AnimatedBuilder(
                animation: _opacityController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacity?.value ?? 0,
                    child: Image.asset("assets/img/icLogo.webp"),
                  );
                },
              ),
            ),
          );
        },
      )
    );
  }

}
