
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';

typedef ValidateEvent = bool Function(String text);
typedef InputValidateBuild = void Function(_ValidateWrapper wrapper);

class InputController extends TextEditingController{

  InputController({
    this.validateBuild,
    this.mask,
    String text
  }) : super(text: text) {
    if (validateBuild != null) {
      _validateWrapper = _ValidateWrapper(this);
      validateBuild(_validateWrapper);
    }
  }

  _ValidateWrapper _validateWrapper;
  BehaviorSubject<String> _errorMsg = BehaviorSubject();
  BehaviorSubject<String> _iconPath = BehaviorSubject();

  Stream getErrorStream() => _errorMsg;
  Stream getIconStream() => _iconPath;

  String mask;

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

  void configureForMask() {
    this.addListener(() {
      this.selection = TextSelection.collapsed(offset: this.text?.length);
    });
  }

  int oldLength = 0;
  void handleMask(String value) {
    if (mask == null) return;
    List<String> textList = text.split('');
    List<String> maskList = mask.split('');

    bool erasing = text.length < oldLength;
    oldLength = text.length;

    if(erasing) return;

    var newText = "";
    for(int i = 0; i < text.length; i++){
      var textChar = textList[i];
      if(i < maskList.length) {
        var maskChar = maskList[i];
        if (maskChar == "#" || textChar == maskChar) {
          newText += textChar;
        } else {
          newText += "$maskChar$textChar";
        }
      }
    }

    text = newText;
    selection = TextSelection.collapsed(offset: newText.length, affinity: TextAffinity.upstream);
  }

  bool isEmpty() => text.length == 0;

  @override
  void dispose() {
    super.dispose();
    _errorMsg.close();
  }
}

class _ValidateWrapper {
  _ValidateWrapper(this.controller);

  final InputController controller;
  final List<_Event> events = List();

  void required(String message){
    events.add(_Event(message, (text) => text.length > 0));
  }

  void minLength(int minLength, String message){
    events.add(_Event(message, (text) => text.length >= minLength));
  }

  void customValidate(String message, ValidateEvent event){
    events.add(_Event(message, event));
  }

  void isEmail(String message){
    events.add(_Event(message, (text) {
      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      return regExp.hasMatch(text);
    }));
  }

  void twoOrMore(String message) {
    events.add(_Event(message, (text) {
      List<String> list = text.trim().split(" ");
      return list.length > 1;
    }));
  }

  void isCreditCard(String message) {
    events.add(_Event(message, (text) {
      var sum = 0, i = 0;
      text = text.replaceAll(RegExp(r'\D'), "");
      text.split('').reversed.forEach((e) {
        int digit = int.parse(e);
        if(i++ % 2 == 1) digit *= 2;
        sum += digit > 9? (digit - 9) : digit;
      });
      return sum % 10 == 0;
    }));
  }

  bool validate(){
    if(events.length == 0){
      return true;
    }
    bool result = true;
    for (_Event event in events) {
      if(!event.event(controller.text.trim())){
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