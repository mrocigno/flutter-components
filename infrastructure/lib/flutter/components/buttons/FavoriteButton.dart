import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/animations/BumpAnimate.dart';

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

  bool _active;
  bool _animate = false;
  void changeState(bool active) {
    setState(() {
      _active = active;
      _animate = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _active = _active ?? widget.active ?? false;

    return Material(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: BumpAnimate(
        startAnimation: _animate,
        onEnd: () => _animate = false,
        child: IconButton(
          icon: (_active?
            Icon(Icons.star, color: Colors.amber) :
            Icon(Icons.star_border)
          ),
          onPressed: () {
            changeState(!_active);
            widget.onPressed(_active);
          }
        ),
      )
    );
  }

}