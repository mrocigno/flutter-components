
import "dart:developer" as dev;
import "package:data/dao/CreditCardDao.dart";
import "package:data/db/Config.dart";
import 'package:data/entity/CreditCard.dart';
import 'package:data/mapper/CreditCardMapper.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/livedata/ResponseStream.dart';

class CreditCardRepository {

  final CreditCardLocal _local = inject();
  final CreditCardRemote _remote = inject();

  Future<List<CreditCard>> refreshCards() async {
    var list = await _remote.getCards();
    if(list.length > 0){
      _local.saveAll(list);
    }
//    return [];
    return list;
  }

  Future<List<CreditCard>> getCards() async {
    return await _local.getAll();
  }

}

class CreditCardLocal {
  CreditCardDao _dao = Config.daoProvider();

  void saveAll(List<CreditCard> list) {
    _dao.deleteAll();
    _dao.saveMany(list);
  }

  Future<List<CreditCard>> getAll() => _dao.getList();

}

class CreditCardRemote {

  CreditCardMapper mapper = inject();

  Future<List<CreditCard>> getCards() async {
    await Future.delayed(Duration(seconds: 1));
//    throw ErrorResponse(message: "erro mesmo");
    return [
      {
        "id": 1,
        "cardHolderName": "Matheus Rocigno",
        "entityFlag": "MASTER",
        "placeHolder": "xxxx xxxx xxxx 1234"
      },
      {
        "id": 2,
        "cardHolderName": "Matheus R medeiros",
        "entityFlag": "VISA",
        "placeHolder": "xxxx xxxx xxxx 4321"
      },
      {
        "id": 3,
        "cardHolderName": "Matheus R medeiros",
        "entityFlag": "VISA",
        "placeHolder": "xxxx xxxx xxxx 5678"
      },
    ].map((e) => mapper.fromResponse(e)).toList();
  }

}
