import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/Background.dart';
import 'package:infrastructure/flutter/constants/Routes.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:mopei_app/src/ui/home/HomeScreen.dart';

class SplashScreen extends StatelessWidget {

  // ignore: close_sinks
  final StreamController<bool> startAnimate = StreamController();

  final GlobalKey _textKey = GlobalKey();
  final GlobalKey _backgroundKey = GlobalKey();
  Background get _widgetBackground => _backgroundKey.currentWidget;

  void toHome(BuildContext context) {
    Navigator.pushReplacement(context, PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
      transitionDuration: Duration(milliseconds: 800),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    double titlePosition = 0;

    Strings.initialize().then((value) {
      RenderBox renderTitle = _widgetBackground.titleKey.currentContext.findRenderObject();
      Offset positionTitle = renderTitle.localToGlobal(Offset.zero);

      RenderBox renderAnimated = _textKey.currentContext.findRenderObject();
      Offset positionAnimated = renderAnimated.localToGlobal(Offset.zero);
      titlePosition = positionAnimated.dy - positionTitle.dy;
      startAnimate.add(true);
    });

    return Background(
      key: _backgroundKey,
      child: Center(
        child: StreamBuilder<bool>(
          stream: startAnimate.stream,
          initialData: false,
          builder: (context, snapshot) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              curve: Curves.ease,
              onEnd: () => toHome(context),
              transform: Matrix4.translationValues(0, (snapshot.data? (titlePosition * -1) : 0), 0),
              child: AnimatedOpacity(
                opacity: snapshot.data? 1 : 0,
                duration: Duration(seconds: 1),
                curve: Curves.ease,
                child: Text("Mopei", key: _textKey, style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ))
              ),
            );
          },
        )
      )
    );
  }

}
