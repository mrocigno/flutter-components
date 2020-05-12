
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

typedef ValidateEvent = bool Function();
typedef InputValidateBuild = void Function(_ValidateWrapper wrapper);

class InputController extends TextEditingController{

  InputController({
    this.validateBuild,
    String text
  }) : super(text: text) {
    if(validateBuild != null){
      _validateWrapper = _ValidateWrapper(this);
      validateBuild(_validateWrapper);
    }
  }

  _ValidateWrapper _validateWrapper;
  BehaviorSubject<String> _errorMsg = BehaviorSubject();
  BehaviorSubject<String> _iconPath = BehaviorSubject();

  Stream getErrorStream() => _errorMsg;
  Stream getIconStream() => _iconPath;

  setError(String msg){
    _errorMsg.add(msg);
    hasError = msg != null;
  }

  setIcon(String path){
    _iconPath.add(path);
    hasIcon = path != null;
  }

  bool hasError = false;
  bool hasIcon = false;
  InputValidateBuild validateBuild;

  bool validate(){
    bool result = _validateWrapper?.validate() ?? true;
    if(result) setError(null);
    return result;
  }
}

class _ValidateWrapper {
  _ValidateWrapper(this.controller);

  final InputController controller;
  final List<_Event> events = List();

  void required(String message){
    events.add(_Event(message, () => controller.text.length > 0));
  }

  void minLength(int minLength, String message){
    events.add(_Event(message, () => controller.text.length >= minLength));
  }

  void customValidate(String message, ValidateEvent event){
    events.add(_Event(message, event));
  }

  void isEmail(String message){
    events.add(_Event(message, () {
      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      return regExp.hasMatch(controller.text);
    }));
  }

  bool validate(){
    if(events.length == 0){
      return true;
    }
    bool result = true;
    for (_Event event in events) {
      if(!event.event()){
        result = false;
        controller.setError(event.message);
      }
    }
    return result;
  }
}

class _Event {
  _Event(this.message, this.event);

  final String message;
  final ValidateEvent event;
}