import 'dart:developer' as dev;
import 'package:flutter/material.dart';

class BumpAnimate extends StatefulWidget {

  final Widget child;
  final bool startAnimation;
  final Function onEnd;

  BumpAnimate({this.child, this.startAnimation, this.onEnd});

  @override
  _BumpAnimateState createState() => _BumpAnimateState();
}

//typedef BumpAnimatedBuilder = Widget Function(AnimationController controller, Animation<double> animation);

class _BumpAnimateState extends State<BumpAnimate> with TickerProviderStateMixin {

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.stop();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: .4), weight: 1.0),
      TweenSequenceItem(tween: Tween(begin: .4, end: 1.5), weight: 1.0),
      TweenSequenceItem(tween: Tween(begin: 1.5, end: 1.0), weight: 1.0),
    ]).animate(_controller);

    if(widget.startAnimation) _controller.forward().then((value) {
      _controller.reset();
      widget.onEnd?.call();
    });

    return ScaleTransition(
        scale: animation,
        child: widget.child
    );
  }
}
