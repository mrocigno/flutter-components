import 'Cart.dart';
import 'Favorite.dart';
import 'Photo.dart';

class Product {

  int id;
  String mainImageUrl;
  String provider;
  String name;
  String description;
  double value;
  bool highlight;
  Favorite favorite;
  Cart cart;
  List<Photo> photos;

  Product({
    this.id,
    this.mainImageUrl = "",
    this.value = 0.0,
    this.provider = "",
    this.name = "",
    this.description = "",
    this.highlight = false,
    this.photos
  });

  @override
  String toString() {
    return [
      id,
      mainImageUrl,
      value,
      provider,
      name,
      description,
      highlight
    ].toString();
  }
  
}