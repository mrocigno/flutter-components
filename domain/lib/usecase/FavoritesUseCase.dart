import 'dart:developer' as dev;

import 'package:domain/entity/Item.dart';
import 'package:domain/repository/FavoriteRepository.dart';

class FavoritesUseCase {

  final FavoriteRepository favoriteRepository;

  FavoritesUseCase({
    this.favoriteRepository
  });

  Future<List<Item>> getFavorites() {
    return favoriteRepository.getAll();
  }

}