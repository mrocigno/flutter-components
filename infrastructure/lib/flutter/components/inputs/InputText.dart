
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/inputs/FormValidate.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:rxdart/rxdart.dart';
import 'dart:developer' as dev;

import 'InputController.dart';

class Input extends StatelessWidget {
  Input(this.theme, {
    this.icon,
    this.keyboardType = TextInputType.text,
    this.hint,
    this.onTapIcon,
    this.margin,
    this.padding,
    this.controller,
    this.obscureText = false
  });

  final InputThemes theme;
  final bool obscureText;
  final String icon;
  final String hint;
  final TextInputType keyboardType;
  final onTapIcon;
  final EdgeInsets margin;
  final EdgeInsets padding;
  InputController controller;

  @override
  Widget build(BuildContext context) {

    controller ??= InputController();
    if(icon != null){
      controller.setIcon(icon);
    }

    FormValidateState.registerForValidate(context, this);

    return Container(
        padding: padding,
        margin: margin,
        child: Stack(
          alignment: Alignment.centerRight,
          overflow: Overflow.visible,
          children: [
            Container(
                height: 60,
                padding: EdgeInsets.only(
                    left: 20,
                    right: (icon != null? 50 : 20)
                ),
                alignment: Alignment.center,
                decoration: theme.background,
                child: Wrap(
                  children: [
                    TextFormField(
                      controller: controller,
                      cursorColor: theme.textColor,
                      keyboardType: keyboardType,
                      obscureText: obscureText,
                      validator: (value) {
                        controller.validate();
                        return ;
                      },
                      style: TextStyle(
                        color: theme.textColor,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hint,
                          hintStyle: TextStyle(
                              color: theme.hintColor
                          )
                      ),
                      onChanged: (value) {
                        controller.setError(null);
                      },
                    ),
                    StreamBuilder<String>(
                      stream: controller.getErrorStream(),
                      builder: (ctx, snapshot) {
                        String errorMsg = snapshot.data;
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          height: controller.hasError? 20 : 0,
                          curve: Curves.ease,
                          transform: Matrix4.translationValues(0, -10, 0),
                          child: Text(errorMsg ?? "",
                              style: TextStyle(color: Constants.Colors.RED_ERROR)
                          ),
                        );
                      },
                    )
                  ],
                )
            ),
            StreamBuilder<String>(
              stream: controller.getIconStream(),
              builder: (ctx, snapshot) {
                if(!controller.hasIcon) return Container();
                String path = snapshot.data;
                return Material(
                  color: Colors.transparent,
                  child: Ink(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Ink.image(image: AssetImage(path ?? icon),
                      height: 30,
                      width: 30,
                      fit: theme.iconFit,
                      child: InkWell(
                        onTap: onTapIcon,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        )
    );
  }
}

class InputThemes {
  InputThemes(this.background, this.textColor, this.hintColor, this.iconFit);

  static InputThemes whiteBackground = InputThemes(
      BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Constants.Colors.WHITE_TRANSPARENT
      ),
      Colors.white,
      Color.fromRGBO(255, 255, 255, .5),
      BoxFit.contain
  );

  static InputThemes blackBackground = InputThemes(
      BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Constants.Colors.BLACK_TRANSPARENT
      ),
      Colors.white,
      Color.fromRGBO(255, 255, 255, .5),
      BoxFit.contain
  );

  static InputThemes searchTheme = InputThemes(
      BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Constants.Colors.BLACK_TRANSPARENT,
        border: Border.all(
          width: 1,
          style: BorderStyle.solid,
          color: Constants.Colors.WHITE_TRANSPARENT
        )
      ),
      Colors.white,
      Color.fromRGBO(255, 255, 255, .5),
      BoxFit.scaleDown
  );

  static InputThemes searchSolidTheme = InputThemes(
      BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white
      ),
      Colors.black,
      Color.fromRGBO(0, 0, 0, .5),
      BoxFit.scaleDown
  );

  final BoxDecoration background;
  final Color textColor;
  final Color hintColor;
  final BoxFit iconFit;
}