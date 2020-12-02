import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {

  void close() {
    Injection.destroyInstance(this);
  }

}