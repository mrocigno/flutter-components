import 'dart:developer' as dev;

import 'package:domain/entity/Item.dart';
import 'package:domain/repository/FavoriteRepository.dart';

class HighlightsUseCase {

  final FavoriteRepository favoriteRepository;

  HighlightsUseCase({this.favoriteRepository});

  void insertFavorite(Item item) async {
    favoriteRepository.insertFavorite(item);
  }

}