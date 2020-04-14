import 'dart:math';
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
  State<StatefulWidget> createState() => AnimatedStartState();

}

class AnimatedStartState extends State<AnimatedStar> {
  bool animate = false;
  void startAnimation(){
    setState(() {
      animate = true;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.autoStart) startAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = 100;
    Duration duration = Duration(milliseconds: 2000);
    double axis = 10;
    double rotate = .5;
    Curve curve = Curves.ease;

    List<Widget> shadow = List.generate(5, (index) => AnimatedContainer(
      duration: duration,
      transform: Matrix4.translationValues(animate? (index + axis) : -(index + axis) , 0, 0)
        ..rotateY(animate? rotate : -rotate),
      width: size, height: size,
      curve: curve,
      child: Icon(Icons.star, color: Colors.amber, size: size,)
    ));

    shadow.add(AnimatedContainer(
      duration: duration,
      height: size, width: size,
      curve: curve,
      alignment: Alignment.center,
      onEnd: () {setState(() {animate = !animate; });},
      transform: Matrix4.rotationY(animate? rotate : -rotate)
        ..setTranslationRaw(animate? axis : -axis, 0, 0),
      child: Icon(Icons.star, color: Colors.amberAccent, size: size,)
    ));

    return Stack(
      alignment: Alignment.center,
      children: shadow
    );
  }
}