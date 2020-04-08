import 'dart:developer' as dev;

import 'package:domain/entity/Item.dart';
import 'package:domain/repository/FavoriteRepository.dart';

class HomeUseCase {

  final FavoriteRepository favoriteRepository;

  HomeUseCase({
    this.favoriteRepository
  });

  Future<List<Item>> getFavorites() {
    return favoriteRepository.getAll();
  }

  void insertFavorite(Item item) async {
    favoriteRepository.insertFavorite(item);
  }

}