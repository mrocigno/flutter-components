import 'dart:developer' as dev;

import 'package:data/repository/CartRepository.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:rxdart/rxdart.dart';

class MainNavigationBloc extends BaseBloc {

  static const int INIT_PAGE = 0;

  CartRepository cartRepository = inject();

  BehaviorSubject<int> _page = BehaviorSubject(seedValue: INIT_PAGE);
  Observable<int> get page => _page.stream;
  BehaviorSubject<bool> _hasItemCart = BehaviorSubject(seedValue: false);
  Observable<bool> get hasItemCart => _hasItemCart.stream;

  void setPage(int page){
    _page.add(page);
  }

  int getPage() => _page.value;

  void checkCart() async => _hasItemCart.add(await cartRepository.hasItem());

}