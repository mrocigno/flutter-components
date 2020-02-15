
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;

class Input extends StatefulWidget {
  Input(this.theme, {
    this.model,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.hint,
    this.onTapIcon
  }) : super();

  final InputModel model;
  final InputThemes theme;
  final String icon;
  final String hint;
  final TextInputType keyboardType;
  final onTapIcon;

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {


  void clearError(){
    setState(() {
      widget.model?.errorMsg = null;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
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
                TextField(
                  controller: widget.model?.controller,
                  cursorColor: widget.theme.textColor,
                  keyboardType: widget.keyboardType,
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
                    clearError();
                  },
                ),
                ((widget.model?.errorMsg) != null?
                Container(
                  transform: Matrix4.translationValues(0, -10, 0),
                  child: Text(widget.model?.errorMsg,
                      style: TextStyle(color: Constants.Colors.RED_ERROR)
                  ),
                ) : Container()
                )
              ],
            )
        ),
        ((widget.model?.iconPath ?? widget.icon) != null?
        Material(
          color: Colors.transparent,
          child: Ink(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Ink.image(image: AssetImage(widget.model?.iconPath ?? widget.icon),
              height: 30,
              width: 30,
              fit: widget.theme.iconFit,
              child: InkWell(
                onTap: widget.onTapIcon,
              ),
            ),
          ),
        ) : Container()
        )
      ],
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

class InputModel {
  InputModel({
    this.controller,
    this.errorMsg,
    this.iconPath
  });

  final TextEditingController controller;
  String errorMsg;
  String iconPath;

}