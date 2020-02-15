

import 'dart:io';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:infrastructure/flutter/components/Input.dart';
import 'package:rxdart/rxdart.dart';

class PageCreateAccountBloc extends BaseBloc {

  // ignore: close_sinks
  BehaviorSubject<InputController> _emailStream, _passwordStream, _confirmPasswordStream, _phoneStream;

  PageCreateAccountBloc() {
    _emailStream = BehaviorSubject();
    _passwordStream = BehaviorSubject();
    _confirmPasswordStream = BehaviorSubject();
    _phoneStream = BehaviorSubject();
  }

  Observable<InputController> get emailStream => _emailStream.stream;
  Observable<InputController> get passwordStream => _passwordStream.stream;
  Observable<InputController> get confirmPasswordStream => _confirmPasswordStream.stream;
  Observable<InputController> get phoneStream => _phoneStream.stream;

  createAccount() {
    launchData(() async {
      await Future.delayed(Duration(seconds: 5));
      dev.log("teste");
    });
  }

}