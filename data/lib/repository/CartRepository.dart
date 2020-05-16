
import "dart:developer" as dev;
import 'package:data/dao/CartDao.dart';
import 'package:data/dao/CategoriesDao.dart';
import 'package:data/db/Config.dart';
import 'package:data/entity/Cart.dart';
import 'package:data/entity/Category.dart';
import 'package:data/entity/Product.dart';
import 'package:data/mapper/CategoryMapper.dart';
import 'package:sqflite/sqflite.dart';
// How cart is only local, we don't need a DataSource
class CartRepository {

  CartDao _dao = Config.daoProvider();

  Future<Cart> getCart(int id) => _dao.getById(id);

  Future<Cart> save(Cart cart) => _dao.save(cart, conflictAlgorithm: ConflictAlgorithm.replace);

  void removeFromCart(Cart cart) => _dao.remove(cart);

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

}

