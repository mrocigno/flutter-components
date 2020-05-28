import 'dart:async';
import 'package:data/local/db/Config.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/animations/ChainAnimations.dart';
import 'package:infrastructure/flutter/base/BaseScreen.dart';
import 'package:infrastructure/flutter/components/backgrounds/Background.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/routing/ScreenTransitions.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:mopei_app/src/ui/main/MainScreen.dart';

class SplashScreen extends StatelessWidget {

//  @override
//  String get name => "SplashScreen";

  // ignore: close_sinks
  final StreamController<bool> startAnimate = StreamController();

  final GlobalKey _textKey = GlobalKey();
  final GlobalKey _titleKey = GlobalKey();

  void toHome(BuildContext context) {
    ScreenTransitions.pushReplacement(context, MainScreen());
  }

  double calculateTitlePosition(){
    RenderBox renderTitle = _titleKey.currentContext.findRenderObject();
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

    Config.open();

    return Background(
      title: Text("", key: _titleKey),
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

