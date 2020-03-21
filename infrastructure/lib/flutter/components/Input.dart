
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:rxdart/rxdart.dart';
import 'dart:developer' as dev;

class Input extends StatelessWidget {
  Input(this.theme, {
    this.icon,
    this.keyboardType = TextInputType.text,
    this.hint,
    this.onTapIcon,
    this.margin,
    this.padding,
    this.controller
  }) : super();

  final InputThemes theme;
  final String icon;
  final String hint;
  final TextInputType keyboardType;
  final onTapIcon;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final InputController controller;

  @override
  Widget build(BuildContext context) {
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
                    TextField(
                      controller: controller,
                      cursorColor: theme.textColor,
                      keyboardType: keyboardType,
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
                    StreamBuilder(
                      stream: controller.errorMsg,
                      builder: (ctx, errorMsg) {
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
            StreamBuilder(
              stream: controller._iconPath,
              builder: (ctx, path) {
                if(!controller.hasIcon) return Container();
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

class InputController extends TextEditingController{

  InputController({
    this.required,
    this.requiredMessage = "Este campo é obrigatório",
    this.minLength = -1,
    this.minLengthMessage
  });

  PublishSubject<String> errorMsg = PublishSubject();
  BehaviorSubject<String> _iconPath = BehaviorSubject();
//  TextEditingController _textEditingController;

//  setText(String text){
//    _textEditingController.text = text;
//  }
//
//  String getText() {
//    return _textEditingController.text;
//  }

  setError(String msg){
    errorMsg.add(msg);
    hasError = msg != null;
  }

  setIcon(String path){
    _iconPath.add(path);
    hasIcon = path != null;
  }

  bool hasError = false;
  bool hasIcon = false;
  final bool required;
  final String requiredMessage;
  final int minLength;
  final String minLengthMessage;

  bool validate(){
    List<bool> test = [
      (required? _checkIsEmpty() : true),
      _checkIsMoreThanMinLength()
    ];
    
    return !test.contains(false);
  }

  bool _checkIsEmpty(){
    if(isEmpty()){
      setError(requiredMessage);
      return false;
    } else {
      return true;
    }
  }

  bool isEmpty(){
    return !(text.trim().length > 0);
  }

  bool _checkIsMoreThanMinLength(){
    if(!isMoreThanMinLength()){
      setError(minLengthMessage ?? "O mínimo de $minLength caracteres");
      return false;
    } else {
      return true;
    }
  }

  bool isMoreThanMinLength() {
    return (text.length >= minLength);
  }
  
  void refresh(BehaviorSubject<InputController> stream) {
    stream.add(this);
  }

}