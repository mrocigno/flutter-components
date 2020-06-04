import 'dart:async';
import 'package:data/local/db/Config.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/animations/ChainAnimations.dart';
import 'package:infrastructure/flutter/base/BaseScreen.dart';
import 'package:infrastructure/flutter/components/backgrounds/Background.dart';
import 'package:infrastructure/flutter/constants/Numbers.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/routing/ScreenTransitions.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:mopei_app/src/ui/main/MainScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

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

  AnimationController _controller;
  Animation<double> _translateY;
  Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000)
    );
  }

  @override
  Widget build(BuildContext context) {
    Strings.initialize().then((value) {
      double position = calculateTitlePosition();

      _opacity = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(.0, .3)
        )
      );

      _translateY = Tween(begin: 0.0, end: position).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(.5, 1.0, curve: Curves.fastOutSlowIn)
        )
      );
      _controller.forward().then((value) {
        toHome();
      });
    });

    Config.open();

    return Background(
        title: Container(height: LOGO_HEIGHT, width: LOGO_WIDTH, key: _titleKey),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Center(
              child: Container(
                key: _logoKey,
                height: LOGO_HEIGHT, width: LOGO_WIDTH,
                transform: Matrix4.translationValues(0, _translateY?.value ?? 0, 0),
                child: Opacity(
                  opacity: _opacity?.value ?? 0,
                  child: Image.asset("assets/img/icLogo.webp"),
                ),
              ),
            );
          },
        )
    );
  }

}
