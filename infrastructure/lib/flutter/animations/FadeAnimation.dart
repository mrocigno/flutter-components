/*
* Created to flutter-components at 05/09/2020
*/
import "dart:developer" as dev;

import 'package:flutter/cupertino.dart';

class FadeAnimation extends StatefulWidget {

  final Duration duration;
  final bool animate;
  final Widget child;
  final double maxHeight;
  final Function onEnd;

  FadeAnimation({
    @required this.duration,
    @required this.child,
    this.animate = false,
    this.maxHeight = 200.0,
    this.onEnd
  });

  @override
  _FadeAnimation createState() => _FadeAnimation();

}

class _FadeAnimation extends State<FadeAnimation> with SingleTickerProviderStateMixin {

  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.duration
    );
  }

  @override
  Widget build(BuildContext context) {

    Animation<double> opacity = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.0, 0.4, curve: Curves.ease))
    );
    Animation<double> size = Tween(begin: widget.maxHeight, end: 0.0).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.4, 1.0, curve: Curves.ease))
    );

    if(widget.animate) controller.forward().then((value) {
      widget.onEnd?.call();
    });
    else controller.reset();

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: opacity.value,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: size.value
            ),
            child: widget.child,
          ),
        );
      },
    );
  }

}