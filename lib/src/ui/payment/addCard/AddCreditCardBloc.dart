/*
* Created to flutter-components at 05/23/2020
*/
import "dart:developer" as dev;

import 'package:data/local/entity/CreditCard.dart';
import 'package:data/repository/CreditCardRepository.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/livedata/MutableResponseStream.dart';
import 'package:infrastructure/flutter/livedata/ResponseStream.dart';

class AddCreditCardBloc {

  MutableResponseStream<CreditCard> _card = MutableResponseStream();
  ResponseStream<CreditCard> get card => _card.observable;
  CreditCardRepository _repository = inject();

  void addCreditCard(CreditCard card) {
    _card.postLoad(() => _repository.addCreditCard(card));
  }

}