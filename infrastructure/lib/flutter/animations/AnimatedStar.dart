import 'dart:math' as math;
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedStar extends StatefulWidget {

  AnimatedStar({
    Key key,
    this.autoStart = false
  }) : super(key: key);

  final bool autoStart;

  @override
  State<StatefulWidget> createState() => AnimatedStarState();

}

class AnimatedStarState extends State<AnimatedStar> with SingleTickerProviderStateMixin {

  AnimationController controller;

  @override
  void initState() {
    super.initState();
    Duration duration = Duration(milliseconds: 1500);
    controller = AnimationController(
        vsync: this,
        duration: duration
    );
  }

  @override
  void dispose() {
    controller?.stop();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = 100;
    Animation<double> rotate = Tween(begin: 0.0, end: math.pi).animate(controller);

    if(widget.autoStart) controller?.repeat();

    List<Widget> shadow = List.generate(5, (index) {
      Animation<double> axis = TweenSequence([
        TweenSequenceItem(tween: Tween(begin: size, end: size + index), weight: 1),
        TweenSequenceItem(tween: Tween(begin: size - index, end: size), weight: 1),
      ]).animate(controller);

      return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {

          return Container(
              transform: Matrix4.identity()
                ..translate(axis.value/2, axis.value/2)
                ..multiply(Matrix4.rotationY(rotate.value))
                ..translate(-(axis.value/2), -(axis.value/2)),
              alignment: Alignment.center,
              height: size, width: size,
              child: Icon(Icons.star, color: Colors.amber, size: size,)
          );
        },
      );
    });

    Animation<double> axis = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: size, end: size - 2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: size + 2, end: size), weight: 1),
    ]).animate(controller);

    shadow.add(AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          transform: Matrix4.identity()
            ..translate(axis.value/2, axis.value/2)
            ..multiply(Matrix4.rotationY(rotate.value))
            ..translate(-(axis.value/2), -(axis.value/2)),
          alignment: Alignment.center,
          height: size, width: size,
          child: Icon(Icons.star, color: Colors.amberAccent, size: size,)
        );
      },
    ));

    return Stack(
      alignment: Alignment.center,
      children: shadow
    );
  }
}