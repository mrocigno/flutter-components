/*
* Created to flutter-components at 05/23/2020
*/
import "dart:developer" as dev;

import 'package:data/local/entity/CreditCard.dart';
import 'package:data/repository/CreditCardRepository.dart';
import 'package:flutter_useful_things/base/BaseBloc.dart';
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:flutter_useful_things/livedata/MutableResponseStream.dart';
import 'package:flutter_useful_things/livedata/ResponseStream.dart';

class AddCreditCardBloc extends BaseBloc {

  MutableResponseStream<CreditCard> _card = MutableResponseStream();
  ResponseStream<CreditCard> get card => _card.observable;
  CreditCardRepository _repository = inject();

  void addCreditCard(CreditCard card) {
    _card.postLoad(() => _repository.addCreditCard(card));
  }

  @override
  void close() {
    _card.close();
  }

}