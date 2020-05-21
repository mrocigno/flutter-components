/*
* Created to flutter-components at 05/20/2020
*/
import "dart:developer" as dev;

import 'package:data/entity/CreditCard.dart';
import 'package:data/repository/CreditCardRepository.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/livedata/ResponseStream.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CardListBloc extends BaseBloc {

  CreditCardRepository creditCardRepository = inject();
  ResponseStream<List<CreditCard>> cards = ResponseStream();
  
  void refreshCards() {
    cards.postLoad(() => creditCardRepository.refreshCards(),
      onError: (data) {
        cards.postLoad(() => creditCardRepository.getCards());
      },
    );
  }
  


}