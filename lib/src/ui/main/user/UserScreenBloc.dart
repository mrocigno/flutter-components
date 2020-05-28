/*
* Created to flutter-components at 05/12/2020
*/
import "dart:developer" as dev;

import 'package:data/local/entity/User.dart';
import 'package:data/repository/UserRepository.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:rxdart/rxdart.dart';

class UserScreenBloc extends BaseBloc {

  UserRepository _userRepository = inject();
  BehaviorSubject<User> _user = BehaviorSubject();
  ValueStream<User> get user => _user.stream;

  void getSession() {
    launchData(() async {
      _user.add(await _userRepository.getSession());
    });
  }

  void closeSession() {
    _userRepository.closeSession();
    _user.add(null);
  }

}