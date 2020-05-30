/*
* Created to flutter-components at 05/12/2020
*/
import "dart:developer" as dev;

import 'package:data/local/entity/User.dart';
import 'package:data/repository/UserRepository.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/livedata/MutableResponseStream.dart';
import 'package:infrastructure/flutter/livedata/ResponseStream.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BaseBloc {

  UserRepository _userRepository = inject();

  MutableResponseStream<User> _user = MutableResponseStream();
  ResponseStream<User> get user => _user.observable;

  void getSession() async {
    _user.postLoad(() => _userRepository.getSession());
  }

  void closeSession() {
    _userRepository.closeSession();
    _user.postLoad(() => null);
  }

  @override
  void close() {
    super.close();
  }

}