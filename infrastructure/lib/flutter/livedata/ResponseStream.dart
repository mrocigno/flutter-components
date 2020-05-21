import 'dart:async';
import 'dart:developer' as dev;
import 'package:rxdart/rxdart.dart';

class ResponseStream<T> {

  final BehaviorSubject<T> _data;
  final BehaviorSubject<bool> _loading = BehaviorSubject(seedValue: false);
  final BehaviorSubject<ErrorResponse> _error = BehaviorSubject();

  Observable<T> get success => _data.stream;
  Observable<bool> get loading => _loading.stream;
  Observable<ErrorResponse> get error => _error.stream;

  final T seedValue;

  ResponseStream({this.seedValue}) : _data = BehaviorSubject(seedValue: seedValue);

  Future<void> postLoad(
    Future<T> execute(),
    {
      void onSuccess(T data),
      void onLoading(bool loading),
      void onError(ErrorResponse data)
    }
  ) async {
    observe(onSuccess: onSuccess, onError: onError, onLoading: onLoading);
    try {
      _loading.add(true);
      _data.add(await execute());
    } catch (exception, stacktrace) {
      dev.log("Error inside postLoad $T");
      dev.log("$exception \n $stacktrace");
      _error.add(exception);
    } finally {
      _loading.add(false);
    }
  }

  void observeLoading(void onLoading(bool loading)) => _loading.listen(onLoading);
  void observeSuccess(void onSuccess(T data)) => _data.listen(onSuccess);
  void observeError(void onError(ErrorResponse error)) => _error.listen(onError);

  void observe({
    void onSuccess(T data),
    void onLoading(bool loading),
    void onError(ErrorResponse error)
  }) {
    if(onSuccess != null) observeSuccess(onSuccess);
    if(onLoading != null) observeLoading(onLoading);
    if(onError != null) observeError(onError);
  }

  void close() {
    _data.close();
    _loading.close();
    _error.close();
  }

}

class ErrorResponse implements Exception {

  int code;
  String message;

  ErrorResponse({this.code, this.message});

  @override
  String toString() {
    return "code = $code, message = $message";
  }

}