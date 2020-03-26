
import 'dart:developer' as dev;
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:rxdart/rxdart.dart';

class PageCreateAccountBloc extends BaseBloc {

  createAccount() {
    launchData(() async {
      await Future.delayed(Duration(seconds: 2));
    });
  }
}