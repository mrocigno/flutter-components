
import "dart:developer" as dev;
import 'package:data/local/dao/CartDao.dart';
import 'package:data/local/db/Config.dart';
import 'package:data/local/entity/Cart.dart';
import 'package:sqflite/sqflite.dart';

// How cart is only local, we don't need a DataSource
class CartRepository {

  CartDao _dao = Config.daoProvider();

  Future<Cart> getCart(int id) => _dao.findById(id);

  Future<Cart> save(Cart cart) => _dao.save(cart, conflictAlgorithm: ConflictAlgorithm.replace);

  Future<void> removeFromCart(Cart cart) => _dao.delete(cart);

  Future<double> calculate() async {
    var list = await _dao.getProducts();
    double result = 0.0;
    list.forEach((map) {
      result += map["value"] * map["amount"];
    });
    return result;
  }

  Future<bool> hasItem() async {
    var list = await _dao.getList();
    return list.length > 0;
  }

  Future<void> addToCart(int productId) => _dao.save(Cart(
    productId: productId,
    amount: 1
  ));

}

