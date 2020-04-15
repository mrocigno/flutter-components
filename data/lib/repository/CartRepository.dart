
import "dart:developer" as dev;
import 'package:data/dao/CartDao.dart';
import 'package:data/dao/CategoriesDao.dart';
import 'package:data/db/Config.dart';
import 'package:data/entity/Cart.dart';
import 'package:data/entity/Category.dart';
import 'package:data/entity/Product.dart';
import 'package:data/mapper/CategoryMapper.dart';
// How cart is only local, we don't need a DataSource
class CartRepository {

  CartDao _dao = Config.daoProvider();

  Future<Cart> getCart(int id) => _dao.getByProductId(id);

  Future<Cart> addToCart(Product product, int amount) => _dao.addToCart(product, amount);

  void removeFromCart(Cart cart) => _dao.removeFromCart(cart);

}

