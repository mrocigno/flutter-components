import 'dart:async';
import 'dart:developer' as dev;
import 'package:infrastructure/flutter/livedata/ErrorResponse.dart';
import 'package:infrastructure/flutter/livedata/ResponseStream.dart';
import 'package:rxdart/rxdart.dart';

class MutableResponseStream<T> {

  final BehaviorSubject<T> data;
  final BehaviorSubject<bool> empty = BehaviorSubject.seeded(false);
  final BehaviorSubject<bool> loading = BehaviorSubject.seeded(false);
  final BehaviorSubject<Exception> error = BehaviorSubject();
  ResponseStream<T> get observable => ResponseStream(this);

  final T seedValue;
  bool get isClosed => data.isClosed;

  MutableResponseStream({this.seedValue}) : data = BehaviorSubject();

  Future<void> postLoad(
    Future<T> execute(),
    {
      void onSuccess(T data),
      void onLoading(bool loading),
      void onError(ErrorResponse data)
    }
  ) async {
    try {
      loading.add(true);
      onLoading?.call(true);

      var response = await execute();
      if(isClosed) return;

      error.add(null);
      if(response == null || (response is List && response.length <= 0)) {
        empty.add(true);
        data.add(null);
      } else {
        empty.add(false);
        data.add(response);
      }
      onSuccess?.call(response);

    } catch (exception, stacktrace) {
      dev.log("Error inside postLoad $T");
      dev.log("$exception \n $stacktrace");
      error.add(exception);
      onError?.call(exception);
    } finally {
      if(!isClosed){
        loading.add(false);
        onLoading?.call(false);
      }
    }
  }

  void addData(T data){
    this.data.add(data);
  }

  void observeLoading(void onLoading(bool loading)) => loading.listen(onLoading);
  void observeSuccess(void onSuccess(T data)) => data.listen(onSuccess);
  void observeError(void onError(ErrorResponse error)) => error.listen(onError);

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
    data.close();
    loading.close();
    error.close();
    empty.close();
  }

  T getSyncValue() {
    return data.value;
  }
}