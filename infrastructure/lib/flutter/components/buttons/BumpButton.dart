/*
* Created to flutter-components at 05/09/2020
*/
import "dart:developer" as dev;
import 'package:infrastructure/flutter/animations/BumpAnimate.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BumpButton extends StatefulWidget {

  final IconData icon;
  final Color activeColor;
  final Color defIconColor;
  final Color defBackgroundColor;
  final double scale;
  final Function onPress;

  BumpButton({
    this.icon,
    this.activeColor,
    this.defBackgroundColor = Constants.Colors.BACKGROUND_WHITE_GRAY,
    this.defIconColor = Colors.black,
    this.scale = 2.0,
    this.onPress
  });

  @override
  _BumpButtonState createState() => _BumpButtonState();

}

class _BumpButtonState extends State<BumpButton> with SingleTickerProviderStateMixin {

  var bump = false;

  var iconColor;
  var backgroundColor;

  AnimationController controller;

  void setDefColor() {
    setState(() {
      iconColor = widget.defIconColor;
      backgroundColor = widget.defBackgroundColor;
      bump = false;
    });
  }

  void setColor() {
    setState(() {
      iconColor = widget.activeColor;
      backgroundColor = widget.activeColor.withOpacity(.2);
      bump = true;
    });
  }

  @override
  void initState() {
    super.initState();
    iconColor = widget.defIconColor;
    backgroundColor = widget.defBackgroundColor;

    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200)
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var animation = Tween(begin: 1.0, end: widget.scale).animate(controller);

    if(bump){
      controller.forward().then((value) {
        controller.reset();
        setDefColor();
      });
    }

    return Material(
      clipBehavior: Clip.hardEdge,
      color: backgroundColor,
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        child: ScaleTransition(
          scale: animation,
          child: IconButton(icon: Icon(widget.icon, color: iconColor), onPressed: () {
            setColor();
            widget.onPress?.call();
          }),
          alignment: Alignment.center,
        ),
      ),
    );
  }

}