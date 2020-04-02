import 'dart:async';
import 'package:rxdart/rxdart.dart';

typedef LaunchData = Future<void> Function();

abstract class BaseBloc {

  // ignore: close_sinks
  PublishSubject<bool> _isLoading = PublishSubject();
  Observable<bool> get isLoading => _isLoading.stream;

  void launchData(LaunchData function) async {
    _isLoading.sink.add(true);
    await function();
    _isLoading.sink.add(false);
  }

}