
import 'dart:developer' as dev;
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/Input.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';

class PageLoginBloc extends BaseBloc {

  // ignore: close_sinks
  BehaviorSubject<InputController> _emailStream, _passwordStream;

  PageLoginBloc() {
    _emailStream = BehaviorSubject(seedValue: InputController(
      required: true,
      minLength: 5
    ));
    _passwordStream = BehaviorSubject(seedValue: InputController());
  }

  Observable<InputController> get emailStream => _emailStream.stream;
  Observable<InputController> get passwordStream => _passwordStream.stream;

  void doLogin() {
    launchData(() async {
      dev.log("${_emailStream.value?.validate()}");
      _emailStream.value.refresh(_emailStream);
//      await Future.delayed(Duration(seconds: 1));
//      String email = _emailStream.value?.text?.trim();
//      String password = _passwordStream?.value?.text;
//
//      if(email == "teste" && password == "123"){
//
//      } else {
//        _emailStream.value?.errorMsg = "e-mail/senha inválidos";
//        _emailStream.sink.add(_emailStream.value);
//      }
    });
  }

}
