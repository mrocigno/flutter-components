import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/animations/ChainAnimations.dart';
import 'package:infrastructure/flutter/components/backgrounds/Background.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/utils/ScreenTransitions.dart';
import 'package:mopei_app/src/ui/home/HomeScreen.dart';

class SplashScreen extends StatelessWidget {

  // ignore: close_sinks
  final StreamController<bool> startAnimate = StreamController();

  final GlobalKey _textKey = GlobalKey();
  final GlobalKey _backgroundKey = GlobalKey();
  Background get _widgetBackground => _backgroundKey.currentWidget;

  void toHome(BuildContext context) {
    ScreenTransitions.pushReplacement(context, HomeScreen());
  }

  double calculateTitlePosition(){
    RenderBox renderTitle = _widgetBackground.titleKey.currentContext.findRenderObject();
    Offset positionTitle = renderTitle.localToGlobal(Offset.zero);

    RenderBox renderAnimated = _textKey.currentContext.findRenderObject();
    Offset positionAnimated = renderAnimated.localToGlobal(Offset.zero);
    return positionAnimated.dy - positionTitle.dy;
  }

  @override
  Widget build(BuildContext context) {

    Strings.initialize().then((value) {
      startAnimate.add(true);
    });

    return Background(
      key: _backgroundKey,
      child: Center(
        child: StreamBuilder<bool>(
          stream: startAnimate.stream,
          initialData: false,
          builder: (context, snapshot) {
            return ChainAnimations(
              startAnimation: snapshot.data,
              child: Text("Mopei", key: _textKey, style: TextStyle(
                fontSize: 20,
                color: Colors.white
              )),
              animations: [
                Animate(
                  sequence: 1,
                  builder: (child, started, onEnd) => AnimatedOpacity(
                      opacity: started? 1 : 0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                      onEnd: onEnd,
                      child: child
                  ),
                ),
                Animate(
                  sequence: 2,
                  builder: (child, started, onEnd) => AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.ease,
                    onEnd: () => toHome(context),
                    transform: Matrix4.translationValues(0, (started? (calculateTitlePosition() * -1) : 0), 0),
                    child: child
                  ),
                )
              ],
            );
          },
        )
      )
    );
  }

}

