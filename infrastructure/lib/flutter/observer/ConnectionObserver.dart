/*
* Created to flutter-components at 05/10/2020
*/
import 'dart:async';
import "dart:developer" as dev;

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/subjects.dart';

abstract class ConnectionBindingObserver {
  void onGrantConnection() {}
  void onLostConnection() {}
}

class ConnectionBinding {
  
  static ConnectionBinding _instance;
  static ConnectionBinding get instance {
    _instance ??= ConnectionBinding();
    return _instance;
  }
  Set<ConnectionBindingObserver> _observers = Set();
  StreamSubscription<ConnectivityResult> connectionObserver;

  ConnectionBinding() {
    connectionObserver = Connectivity().onConnectivityChanged.listen((event) {
      _handleConnection(event);
    });
  }

  void _handleConnection(ConnectivityResult result) {
    switch(result){
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        _onGrantConnection();
        break;
      case ConnectivityResult.none:
        _onLostConnection();
        break;
    }
  }
  
  void addObserver(ConnectionBindingObserver observer){
    _observers.add(observer);
  }
  
  void _onLostConnection() {
    _observers.forEach((element) { element.onLostConnection(); });
  }
  
  void _onGrantConnection() {
    _observers.forEach((element) { element.onGrantConnection(); });
  }

  void _checkConnection() async {
    var result = await Connectivity().checkConnectivity();
    if(result != ConnectivityResult.none){
      _onGrantConnection();
    } else {
      _onLostConnection();
    }
  }

}