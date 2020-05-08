import 'package:data/entity/Cart.dart';
import 'package:data/entity/Favorite.dart';

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

  Product({
    this.id,
    this.mainImageUrl = "",
    this.value = 0.0,
    this.provider = "",
    this.name = "",
    this.description = "",
    this.highlight = false
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