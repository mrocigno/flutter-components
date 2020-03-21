

import 'dart:io';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:infrastructure/flutter/components/Input.dart';
import 'package:infrastructure/flutter/livedata/InputStream.dart';
import 'package:rxdart/rxdart.dart';

class PageForgotPasswordBloc extends BaseBloc {

  // ignore: close_sinks
//  CustomBehaviorSubject<InputController> _emailStream;
//  InputController _emailController = InputController(
//    required: true
//  );

  PageForgotPasswordBloc() {
//    _emailStream = BehaviorSubject(seedValue: _emailController);
  }

//  Observable<InputController> get emailStream => _emailStream.stream;

  createAccount() {
//    launchData(() async {
//      if(_emailController.validate()){
//        await Future.delayed(Duration(seconds: 5));
//        _emailController.errorMsg = "asd";
//        _emailStream.notify();
//      }
//    });
  }

}