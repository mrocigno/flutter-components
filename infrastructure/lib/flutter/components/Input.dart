
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:rxdart/rxdart.dart';

class Input extends StatefulWidget {
  Input(this.theme, {
    this.icon,
    this.keyboardType = TextInputType.text,
    this.hint,
    this.onTapIcon,
    this.margin,
    this.padding,
    this.stream
  }) : super();

  final InputThemes theme;
  final String icon;
  final String hint;
  final TextInputType keyboardType;
  final onTapIcon;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Stream<InputController> stream;

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {

  void clearError(InputController model){
    setState(() {
      model?.errorMsg = null;
    });
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        InputController model = snapshot.data;
        
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
                    TextField(
                      controller: model,
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
                        clearError(model);
                      },
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: model?.errorMsg != null? 20 : 0,
                      curve: Curves.ease,
                      transform: Matrix4.translationValues(0, -10, 0),
                      child: Text(model?.errorMsg ?? "",
                        style: TextStyle(color: Constants.Colors.RED_ERROR)
                      ),
                    )
                  ],
                )
              ),
              ((model?.iconPath ?? widget.icon) != null?
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Ink.image(image: AssetImage(model?.iconPath ?? widget.icon),
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
          )
        );
      }
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

class InputController extends TextEditingController {

  InputController({
    this.required,
    this.requiredMessage = "Este campo é obrigatório",
    this.minLength = -1,
    this.minLengthMessage
  });

  String errorMsg;
  String iconPath;

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
      errorMsg = requiredMessage;
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
      errorMsg = minLengthMessage ?? "O mínimo de caracteres é $minLength";
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