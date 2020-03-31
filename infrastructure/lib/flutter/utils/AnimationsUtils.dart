import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class AnimationsUtils extends StatelessWidget {
  AnimationsUtils({
    this.child,
    this.animations,
    this.startAnimation
  });

  final List<Animate> animations;
  final Widget child;
  final bool startAnimation;
  final ValueNotifier _notifier = ValueNotifier(0);

  void upSequence() {
    _notifier.value = _notifier.value + 1;
  }

  @override
  Widget build(BuildContext context) {

    if(startAnimation){
      _notifier.value = 1;
    }

    return AnimatedBuilder(
      animation: _notifier,
      child: child,
      builder: (context, child) {
        Widget widget = child;
        animations.forEach((element) {
          widget = element.builder(widget, (_notifier.value >= element.sequence), upSequence);
          if(_notifier.value == element.sequence) element.onStart?.call();
        });
        return widget;
      },
    );
  }
}

typedef Builder = Widget Function(Widget child, bool started, Function onEnd);

class Animate {

  Animate({
    this.builder,
    this.delay,
    this.sequence,
    this.onStart
  });

  final Function onStart;
  final int sequence;
  final Duration delay;
  final Builder builder;

}