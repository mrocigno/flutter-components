
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infrastructure/flutter/components/inputs/FormValidate.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:rxdart/rxdart.dart';
import 'dart:developer' as dev;

import 'InputController.dart';

class Input extends StatefulWidget {

  final InputThemes theme;
  final bool obscureText;
  final String icon;
  final Color iconColor;
  final String hint;
  final TextInputType keyboardType;
  final onTapIcon;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final ValueChanged<String> onFieldSubmitted;
  final FocusNode focusNode;
  final InputController controller;
  final Function(String text) onTextChanged;

  Input(this.theme, {
    this.icon,
    this.iconColor,
    this.keyboardType = TextInputType.text,
    this.hint,
    this.onTapIcon,
    this.margin,
    this.padding,
    this.controller,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.focusNode,
    this.onTextChanged
  });

  @override
  InputState createState() => InputState();

}

class InputState extends State<Input> {

  @override
  Widget build(BuildContext context) {

    var _controller = widget.controller ?? InputController();
    if(widget.icon != null){
      _controller.setIcon(widget.icon);
    }

    FormValidateState.registerForValidate(context, this);

    return Container(
        padding: widget.padding,
        margin: widget.margin,
        child: Stack(
          alignment: Alignment.centerRight,
          overflow: Overflow.visible,
          children: [
            Container(
                height: 60,
                padding: EdgeInsets.only(
                    left: 20,
                    right: (widget.icon != null? 50 : 20)
                ),
                alignment: Alignment.center,
                decoration: widget.theme.background,
                child: Wrap(
                  children: [
                    TextFormField(
                      controller: _controller,
                      cursorColor: widget.theme.textColor,
                      keyboardType: widget.keyboardType,
                      obscureText: widget.obscureText,
                      focusNode: widget.focusNode,
                      onFieldSubmitted: widget.onFieldSubmitted,
                      validator: (value) {
                        _controller.validate();
                        return;
                      },
                      style: TextStyle(
                        color: widget.theme.textColor,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.hint,
                          hintStyle: TextStyle(
                              color: widget.theme.hintColor
                          )
                      ),
                      onChanged: (value) {
                        _controller.setError(null);
                        _controller.handleMask(value);
                        widget.onTextChanged?.call(value);
                      },
                    ),
                    StreamBuilder<String>(
                      stream: _controller.getErrorStream(),
                      builder: (ctx, snapshot) {
                        String errorMsg = snapshot.data;
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          height: _controller.hasError? 20 : 0,
                          curve: Curves.ease,
                          transform: Matrix4.translationValues(0, (_controller.hasError? -10 : 10), 0),
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
              stream: _controller.getIconStream(),
              builder: (ctx, snapshot) {
                if(!_controller.hasIcon) return Container();
                String path = snapshot.data;
                return Material(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: IconButton(
                      icon: Image.asset(path ?? widget.icon,
                        width: 30,
                        height: 30,
                        fit: widget.theme.iconFit,
                        color: widget.iconColor,
                      ),
                      onPressed: widget.onTapIcon
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
  InputThemes({
    this.background, this.textColor, this.hintColor, this.iconFit
  });

  static InputThemes whiteBackground = InputThemes(
      textColor: Colors.white,
      hintColor: Color.fromRGBO(255, 255, 255, .5),
      iconFit: BoxFit.contain,
      background: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Constants.Colors.WHITE_TRANSPARENT_MEDIUM
      )
  );

  static InputThemes blackBackground = InputThemes(
    textColor: Colors.white,
    hintColor: Color.fromRGBO(255, 255, 255, .5),
    iconFit: BoxFit.contain,
    background: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Constants.Colors.BLACK_TRANSPARENT_LOW
    )
  );

  static InputThemes loginTheme = InputThemes(
      textColor: Colors.black,
      hintColor: Color.fromRGBO(0, 0, 0, .5),
      iconFit: BoxFit.contain,
      background: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Constants.Colors.BLACK_TRANSPARENT_LOW
      )
  );

  static InputThemes searchLightTheme = InputThemes(
    textColor: Colors.white,
    hintColor: Color.fromRGBO(255, 255, 255, .5),
    iconFit: BoxFit.scaleDown,
    background: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Constants.Colors.BLACK_TRANSPARENT_LOW,
      border: Border.all(
        width: 1,
        style: BorderStyle.solid,
        color: Constants.Colors.WHITE_TRANSPARENT_MEDIUM
      )
    )
  );

  static InputThemes searchDarkTheme = InputThemes(
    textColor: Colors.black,
    hintColor: Color.fromRGBO(0, 0, 0, .5),
    iconFit: BoxFit.scaleDown,
    background: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Constants.Colors.BLACK_TRANSPARENT_LOWER,
      border: Border.all(
        width: 1,
        style: BorderStyle.solid,
        color: Constants.Colors.BLACK_TRANSPARENT_LOW
      )
    )
  );

  static InputThemes searchSolidTheme = InputThemes(
    textColor: Colors.black,
    hintColor: Color.fromRGBO(0, 0, 0, .5),
    iconFit: BoxFit.scaleDown,
    background: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.white
    )
  );

  final BoxDecoration background;
  final Color textColor;
  final Color hintColor;
  final BoxFit iconFit;
}