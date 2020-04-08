
import "dart:developer" as dev;
import 'package:data/dao/ProductsDao.dart';
import 'package:data/db/Config.dart';
import 'package:data/mapper/ProductMapper.dart';
import 'package:data/model/ProductResponse.dart';
import 'package:domain/entity/Product.dart';
import "package:domain/repository/ProductsRepository.dart";

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsLocal local;
  final ProductsRemote remote;

  ProductsRepositoryImpl({
      this.local,
      this.remote
  });

  @override
  Future<List<Product>> getHighlights() {
    return local.getHighlights();
  }

  @override
  void setFavorite(Product product) {
    local.setFavorite(product);
  }

  @override
  Future<void> refreshProducts() async {
    List<Product> products = await remote.getProducts();
    products.forEach((element) {
      local.addProduct(element);
    });
  }

  @override
  Future<List<Product>> getFavorites() {
    return local.getFavorites();
  }

}

class ProductsLocal {
  ProductsDao dao = Config.daoProvider();

  void addProduct(Product product){
    dao.addProduct(product);
  }

  void setFavorite(Product product){
    dao.setFavorite(product);
  }

  Future<List<Product>> getHighlights() {
    return dao.getHighlights();
  }

  Future<List<Product>> getFavorites() {
    return dao.getFavorites();
  }
}

class ProductsRemote {

  Future<List<Product>> getProducts() async {
    await Future.delayed(Duration(seconds: 2));
    ProductMapper mapper = ProductMapper();
    return [
        ProductResponse(
          id: 1,
          mainImageUrl: "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094414550HDR.JPG",
          value: 20.00,
          name: "Retrovisor"
        ),
        ProductResponse(
          id: 2,
          mainImageUrl: "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094426318.jpg",
          value: 19.99,
          name: "Retrovisor de lado"
        ),
        ProductResponse(
          id: 3,
          mainImageUrl: "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094443068.jpg",
          value: 200.99,
          name: "Retrovisor de lado"
        ),
        ProductResponse(
          id: 4,
          mainImageUrl: "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094509685.jpg",
          value: 10.00,
          name: "Retrovisor por baixo"
        ),
      ].map((e) => mapper.transform(e)).toList();
  }

}
