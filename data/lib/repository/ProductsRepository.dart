
import "dart:developer" as dev;
import 'package:data/dao/ProductsDao.dart';
import 'package:data/db/Config.dart';
import 'package:data/entity/Product.dart';
import 'package:data/mapper/ProductMapper.dart';

class ProductsRepository {
  final ProductsLocal local;
  final ProductsRemote remote;

  ProductsRepository({
      this.local,
      this.remote
  });

  Future<List<Product>> getHighlights() => local.getHighlights();

  Future<List<Product>> getFavorites() => local.getFavorites();

  Future<Product> getById(int id) => local.getById(id);

  void setFavorite(Product product) => local.setFavorite(product);

  Future<void> refreshProducts() async {
    List<Product> products = await remote.getProducts();
    products.forEach((element) {
      local.addProduct(element);
    });
  }
}

class ProductsLocal {
  ProductsDao dao = Config.daoProvider();

  void addProduct(Product product) => dao.addOne(product);

  void setFavorite(Product product) => dao.setFavorite(product);

  Future<Product> getById(int id) => dao.getById(id);

  Future<List<Product>> getHighlights() => dao.getHighlights();

  Future<List<Product>> getFavorites() => dao.getFavorites();
}

class ProductsRemote {

  Future<List<Product>> getProducts() async {
    await Future.delayed(Duration(seconds: 2));
    ProductMapper mapper = ProductMapper();
    return [
        {
          "id": 1,
          "mainImageUrl": "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094414550HDR.JPG",
          "value": 20.00,
          "provider": "Honda",
          "name": "Retrovisor",
          "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore."
        },
        {
          "id": 2,
          "mainImageUrl": "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094426318.jpg",
          "value": 19.99,
          "provider": "Honda",
          "name": "Retrovisor de lado",
          "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore."
        },
        {
          "id": 3,
          "mainImageUrl": "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094443068.jpg",
          "value": 200.99,
          "provider": "Honda",
          "name": "Retrovisor de lado",
          "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore."
        },
        {
          "id": 4,
          "mainImageUrl": "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094509685.jpg",
          "value": 10.00,
          "provider": "Honda",
          "name": "Retrovisor por baixo",
          "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore."
        }
      ].map((e) => mapper.fromResponse(e)).toList();
  }

}
