
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/animations/AnimatedStar.dart';
import 'package:infrastructure/flutter/components/image/ImagePlaceholder.dart';

class WhiteTable extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: ImagePlaceholder()
        )
      ),
    );
  }
}