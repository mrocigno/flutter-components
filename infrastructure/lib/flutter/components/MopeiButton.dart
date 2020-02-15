import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;

class MopeiButton extends StatelessWidget {
  MopeiButton(this.theme, {
    this.onTap,
    this.text,
    this.isLoading
  });

  final MopeiButtonTheme theme;
  final onTap;
  final String text;
  final Stream<bool> isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: theme.buttonBackground.borderRadius,
      color: Colors.transparent,
      child: Ink(
        height: 50,
        decoration: theme.buttonBackground,
        width: double.maxFinite,
        child: InkWell(
          borderRadius: theme.buttonBackground.borderRadius,
          onTap: onTap,
          child: Center(
            child: StreamBuilder(
              stream: isLoading ?? StreamController<bool>().stream,
              initialData: false,
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if(snapshot.data){
                  return Container(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(theme.progressColor),
                      strokeWidth: 2,
                    ),
                  );
                } else {
                  return Text(text?.toUpperCase() ?? "",
                    style: theme.textStyle,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MopeiButtonTheme {

  MopeiButtonTheme(this.textStyle, this.buttonBackground, this.elevation, this.progressColor);

  final BoxDecoration buttonBackground;
  final TextStyle textStyle;
  final double elevation;
  final Color progressColor;

  static MopeiButtonTheme mainTheme = MopeiButtonTheme(
    TextStyle(
      color: Colors.white
    ),
    BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Constants.Colors.GRADIENT_BUTTON_INI,
          Constants.Colors.GRADIENT_BUTTON_END
        ]
      )
    ),
    0,
    Colors.black
  );

  static MopeiButtonTheme outlined = MopeiButtonTheme(
      TextStyle(
          color: Constants.Colors.GRADIENT_BUTTON_END
      ),
      BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Constants.Colors.GRADIENT_BUTTON_END, style: BorderStyle.solid, width: 1)
      ),
      2,
      Colors.black
  );

}