import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_useful_things/animations/BumpAnimate.dart';

class FavoriteButton extends StatefulWidget {

  final bool active;
  final FavoriteButtonPressed onPressed;

  FavoriteButton({
    this.active,
    this.onPressed
  });

  @override
  State<StatefulWidget> createState() => FavoriteButtonState();
}

typedef FavoriteButtonPressed = Function(bool active);

class FavoriteButtonState extends State<FavoriteButton> {

  bool _animate = false;
  void changeState(bool active) {
    setState(() {
      _animate = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Material(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: BumpAnimate(
        startAnimation: _animate,
        onEnd: () => _animate = false,
        child: IconButton(
          icon: (widget.active?
            Icon(Icons.star, color: Colors.amber) :
            Icon(Icons.star_border)
          ),
          onPressed: () {
            changeState(!widget.active);
            widget.onPressed?.call(!widget.active);
          }
        ),
      )
    );
  }

}