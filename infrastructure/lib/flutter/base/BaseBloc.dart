import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

typedef LaunchData = Future<void> Function();

abstract class BaseBloc {

  // ignore: close_sinks
  BehaviorSubject<bool> _isLoading = BehaviorSubject();
  Stream<bool> get isLoading => _isLoading.stream;

  @protected
  void launchData(LaunchData function) async {
    _isLoading.sink.add(true);
    await function();
    _isLoading.sink.add(false);
  }

}