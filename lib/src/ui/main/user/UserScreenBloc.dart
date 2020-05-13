/*
* Created to flutter-components at 05/12/2020
*/
import "dart:developer" as dev;

import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:rxdart/rxdart.dart';

class UserScreenBloc extends BaseBloc {

  BehaviorSubject<bool> _isSigned = BehaviorSubject();
  Observable<bool> get isSigned => _isSigned.stream;

  void setSigned() {
    _isSigned.add(true);
  }

}