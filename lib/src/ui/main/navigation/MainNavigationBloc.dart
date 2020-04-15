import 'dart:developer' as dev;

import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:rxdart/rxdart.dart';

class MainNavigationBloc extends BaseBloc {

  static const int INIT_PAGE = 0;

  BehaviorSubject<int> _page = BehaviorSubject(seedValue: INIT_PAGE);
  Observable<int> get page => _page.stream;

  void setPage(int page){
    _page.add(page);
  }

  int getPage() => _page.value;

}