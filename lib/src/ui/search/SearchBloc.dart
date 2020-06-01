/*
* Created to flutter-components at 05/11/2020
*/
import "dart:developer" as dev;

import 'package:data/local/entity/Favorite.dart';
import 'package:data/local/entity/Product.dart';
import 'package:data/repository/AutoCompleteRepository.dart';
import 'package:data/repository/FavoritesRepository.dart';
import 'package:data/repository/ProductsRepository.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/livedata/MutableResponseStream.dart';
import 'package:infrastructure/flutter/livedata/ResponseStream.dart';
import 'package:infrastructure/flutter/utils/IterableUtils.dart';
import 'package:mopei_app/src/ui/search/data/AutoCompleteModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';


class SearchBloc extends BaseBloc {

  final ProductsRepository _productsRepository = inject();
  final FavoritesRepository _favoritesRepository = inject();
  final AutoCompleteRepository _autoCompleteRepository = inject();

  MutableResponseStream<List<Product>> _products = MutableResponseStream();
  ResponseStream<List<Product>> get products => _products.observable;

  MutableResponseStream<List<AutoCompleteModel>> _autoComplete = MutableResponseStream();
  ResponseStream<List<AutoCompleteModel>> get autoComplete => _autoComplete.observable;

  BehaviorSubject<bool> _typing = BehaviorSubject.seeded(false);
  Stream<bool> get typing => _typing.stream;

  set isTyping(bool value) {
    if(_typing.value != value) _typing.value = value;
  }

  bool get isTyping => _typing.value;

  void handleAutoComplete(String search) {
    _autoComplete.postLoad(() async {
      List<String> history = await _autoCompleteRepository.getHistory(search);
      List<AutoCompleteModel> response = history.map((e) => AutoCompleteModel(
        text: e,
        iconType: IconType.HISTORY
      )).toList();

      try {
        List<String> autoComplete = await _autoCompleteRepository.autoComplete(search);
        response.addAll(autoComplete?.map((e) => AutoCompleteModel(
            text: e,
            iconType: IconType.SEARCH
        ))?.toList());
      } catch (e) { dev.log("$e"); }

      return response;
    });
  }

  void addToFavorite(Favorite favorite) {
    _favoritesRepository.addToFavorites(favorite.productId);
  }

  void removeFromFavorite(Favorite favorite) {
    _favoritesRepository.removeFromFavorite(favorite);
  }

  void notifyDataChange() async {
    List<Product> products = _products.getSyncValue();
    String ids = products.joinString((e) => e.id);
    _products.addData(await _productsRepository.listByIds(ids));
  }

  void performSearch(String search) {
    _products.postLoad(() async {
      List<Product> list = await _productsRepository.search(search);
      if(list.length > 0) _autoCompleteRepository.saveSearch(search);
      return list;
    });
  }

  void getHistory(String search) {
    _autoComplete.postLoad(() async => (await _autoCompleteRepository.getHistory(search)).map((e) {
      return AutoCompleteModel(
        iconType: IconType.HISTORY,
        text: e
      );
    }).toList());
  }

  @override
  void close() {
    super.close();
    _products.close();
    _autoComplete.close();
    _typing.close();
  }

}