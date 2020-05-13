
import 'dart:developer' as dev;

import 'package:data/entity/User.dart';
import 'package:data/repository/UserRepository.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/livedata/ResponseStream.dart';
import 'package:rxdart/rxdart.dart';

class PageLoginBloc extends BaseBloc {

  UserRepository _userRepository = inject();
  // TODO: create mutable response
  ResponseStream<User> user = ResponseStream();

  void doLogin({String email, String password}) {
    user.postLoad(() => _userRepository.doLogin(email, password));
  }
}