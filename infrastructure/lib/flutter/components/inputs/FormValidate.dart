import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/components/inputs/InputText.dart';

class FormValidate extends StatefulWidget {
  FormValidate({
    Key key,
    this.child
  }) : super(key: key);

  final Widget child;

  @override
  FormValidateState createState() => FormValidateState();

}

class FormValidateState extends State<FormValidate> {

  List<Input> _inputs = List();
  static void registerForValidate(BuildContext context, Input input) {
    _FormValidateScope state = context.dependOnInheritedWidgetOfExactType<_FormValidateScope>();
    state?.state?._register(input);
  }

  void _register(Input input){
    _inputs.add(input);
  }

  @override
  Widget build(BuildContext context) {
    return _FormValidateScope(
      state: this,
      child: Container(
        child: widget.child,
      ),
    );
  }

  bool validate(){
    bool error = false;
    for (Input child in _inputs){
      if(!child.controller.validate()){
        error = true;
      }
    }
    return !error;
  }

}

class _FormValidateScope extends InheritedWidget {
  _FormValidateScope({
    key,
    child,
    this.state
  }) : super(key: key, child: child);

  final FormValidateState state;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

}