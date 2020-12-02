
import 'dart:developer' as dev;

import 'package:data/local/entity/User.dart';
import 'package:data/repository/UserRepository.dart';
import 'package:flutter_useful_things/base/BaseBloc.dart';
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:flutter_useful_things/livedata/MutableResponseStream.dart';
import 'package:rxdart/rxdart.dart';

class PageLoginBloc extends BaseBloc {

  UserRepository _userRepository = inject();
  // TODO: create mutable response
  MutableResponseStream<User> user = MutableResponseStream();

  void doLogin({String email, String password}) {
    user.postLoad(() => _userRepository.doLogin(email, password));
  }

  @override
  void close() {
    user.close();
  }
}