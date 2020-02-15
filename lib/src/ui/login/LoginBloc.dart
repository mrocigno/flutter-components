
import 'dart:developer' as dev;
import 'dart:async';
import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/Input.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';

class LoginBloc extends BaseBloc {

  InputModel emailInput = InputModel(controller: TextEditingController());
  InputModel passwordInput = InputModel(controller: TextEditingController());
  BehaviorSubject<InputModel> _emailStream;
  BehaviorSubject<InputModel> _passwordStream;

  LoginBloc() {
    _emailStream = BehaviorSubject(seedValue: emailInput);
    _emailStream = BehaviorSubject(seedValue: emailInput);
  }

  Observable<InputModel> get emailStream => _emailStream.stream;
  Observable<InputModel> get passwordStream => _passwordStream.stream;


  void doLogin() {
    launchData(() async {
      await Future.delayed(Duration(seconds: 3));
      String email = emailInput.controller.text.trim();
      String password = emailInput.controller.text;

      if(email == "teste" && password == "123"){

      } else {
        emailInput.errorMsg = "e-mail/senha inválidos";
        _emailStream.sink.add(emailInput);
      }
    });
  }

}