
import "dart:developer" as dev;
import 'package:data/dao/ProductsDao.dart';
import 'package:data/db/Config.dart';
import 'package:data/entity/Product.dart';
import 'package:data/mapper/ProductMapper.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:sqflite/sqflite.dart';

class ProductsRepository {
  final ProductsLocal _local = inject();
  final ProductsRemote _remote = inject();

  Future<List<Product>> getHighlights() => _local.getHighlights();

  Future<List<Product>> getFavorites() => _local.getFavorites();

  Future<List<Product>> getInCart() => _local.getInCart();

  Future<List<Product>> search(String search) => _local.search(search);

  Future<Product> getById(int id) => _local.getById(id);

  Future<void> refreshProducts() async {
    List<Product> products = await _remote.getProducts();
    _local.saveAll(products);
  }
}

class ProductsLocal {
  ProductsDao dao = Config.daoProvider();

  void addProduct(Product product) => dao.save(product, conflictAlgorithm: ConflictAlgorithm.replace);

  void saveAll(List<Product> list) => dao.saveMany(list, conflictAlgorithm: ConflictAlgorithm.replace);

  Future<Product> getById(int id) => dao.getById(id);

  Future<List<Product>> getHighlights() => dao.getHighlights();

  Future<List<Product>> getFavorites() => dao.getFavorites();

  Future<List<Product>> getInCart() => dao.getInCart();

  Future<List<Product>> search(String search) => dao.search(search);
}

class ProductsRemote {

  Future<List<Product>> getProducts() async {
    ProductMapper mapper = inject();
    var list = List.generate(500, (index) {
      return Product(
        name: "Teste $index",
        value: 2000,
        provider: "Honda",
        mainImageUrl: "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094414550HDR.JPG",
        highlight: true,
        description: "Teste",
        id: index
      );
    });
    return list;
//    return [
//        {
//          "id": 1,
//          "mainImageUrl": "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094414550HDR.JPG",
//          "value": 20.00,
//          "provider": "Honda",
//          "name": "Retrovisor",
//          "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.",
//          "highlight": 1
//        },
//        {
//          "id": 2,
//          "mainImageUrl": "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094426318.jpg",
//          "value": 19.99,
//          "provider": "Honda",
//          "name": "Retrovisor de perfil",
//          "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.",
//          "highlight": 1
//        },
//        {
//          "id": 3,
//          "mainImageUrl": "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094443068.jpg",
//          "value": 200.99,
//          "provider": "Honda",
//          "name": "Retrovisor de lado",
//          "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.",
//          "highlight": 1
//        },
//        {
//          "id": 4,
//          "mainImageUrl": "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094509685.jpg",
//          "value": 10.00,
//          "provider": "Honda",
//          "name": "Retrovisor por baixo",
//          "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.",
//          "highlight": 1
//        },
//        {
//          "id": 5,
//          "mainImageUrl": "https://crestana.com.br/img/imagens_produto/20190702_143705_1____11111111.JPG",
//          "value": 44.50,
//          "provider": "Honda",
//          "name": "Lanterna de seta",
//          "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.",
//          "highlight": 1
//        },
//        {
//          "id": 6,
//          "mainImageUrl": "https://crestana.com.br/img/imagens_produto/20200131_151337_1____1.JPG",
//          "value": 201.09,
//          "provider": "Honda",
//          "name": "Ventoinha",
//          "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore."
//        },
//        {
//          "id": 7,
//          "mainImageUrl": "https://crestana.com.br/img/imagens_produto/20181018_155531_____ACTERM08.JPG",
//          "value": 119.00,
//          "provider": "Honda",
//          "name": "Fita termica",
//          "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore."
//        },
//        {
//          "id": 8,
//          "mainImageUrl": "https://crestana.com.br/img/imagens_produto/20190103_161406_____DSC03444.JPG",
//          "value": 210.99,
//          "provider": "Honda",
//          "name": "Polia de amortecedor",
//          "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore."
//        },
//        {
//          "id": 9,
//          "mainImageUrl": "https://crestana.com.br/img/imagens_produto/20180606_094149_____DSC00891.JPG",
//          "value": 275.99,
//          "provider": "Honda",
//          "name": "Bomba de circulação de óleo",
//          "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore."
//        },
//        {
//          "id": 10,
//          "mainImageUrl": "https://crestana.com.br/img/imagens_produto/20181107_140851_____DSC02655.JPG",
//          "value": 63.99,
//          "provider": "Honda",
//          "name": "Sensor de freio",
//          "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore."
//        }
//      ].map((e) => mapper.fromResponse(e)).toList();
  }

}
