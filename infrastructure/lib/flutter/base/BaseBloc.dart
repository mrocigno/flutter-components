
import 'dart:async';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {

  PublishSubject<bool> _isLoading = PublishSubject();
  Observable<bool> get isLoading => _isLoading.stream;

  void launchData(Future<void> function()) async {
    _isLoading.sink.add(true);
    await function();
    _isLoading.sink.add(false);
  }

}