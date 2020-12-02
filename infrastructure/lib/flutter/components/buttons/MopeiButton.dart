import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:core/constants/Colors.dart' as Constants;

class MopeiButton extends StatelessWidget {
  MopeiButton({
    this.theme,
    this.onTap,
    this.text,
    this.isLoading
  });

  final MopeiButtonTheme theme;
  final Function onTap;
  final String text;
  final Stream<bool> isLoading;

  @override
  Widget build(BuildContext context) {
    MopeiButtonTheme _theme = theme ?? MopeiButtonTheme.mainTheme;

    return StreamBuilder(
      stream: isLoading ?? StreamController<bool>().stream,
      initialData: false,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        bool isLoading = snapshot.data;
        return Material(
          borderRadius: _theme.buttonBackground.borderRadius,
          color: Colors.transparent,
          child: Ink(
            height: 50,
            decoration: (isLoading? _theme.buttonDisabledBackground : _theme.buttonBackground),
            width: double.maxFinite,
            child: InkWell(
              borderRadius: _theme.buttonBackground.borderRadius,
              onTap: (isLoading? null : onTap),
              child: Center(
                child: (isLoading?
                  Container(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(_theme.progressColor),
                      strokeWidth: 2,
                    ),
                  ) : Text(text?.toUpperCase() ?? "",
                    style: _theme.textStyle,
                  )
                )
              ),
            ),
          ),
        );
      }
    ) ;
  }
}

class MopeiButtonTheme {

  MopeiButtonTheme(this.textStyle, this.buttonBackground, this.buttonDisabledBackground, this.elevation, this.progressColor);

  final BoxDecoration buttonBackground;
  final BoxDecoration buttonDisabledBackground;
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
    BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.grey,
              Colors.blueGrey
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
      BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 1)
      ),
      2,
      Colors.black
  );

}