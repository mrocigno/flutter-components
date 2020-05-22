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

  BehaviorSubject<CreditCard> _selectedCard = BehaviorSubject();
  Observable<CreditCard> get selectedCard => _selectedCard.stream;

  void refreshCards() {
    cards.postLoad(() => creditCardRepository.refreshCards(),
      onError: (data) {
        cards.postLoad(() => creditCardRepository.getCards());
      },
    );
  }

  void selectCardByPosition(int index) {
    _selectedCard.add(cards.getSyncValue()[index]);
  }

  void removeCard() async {
    await creditCardRepository.removeCard(_selectedCard.value..isRemoved = true);
    cards.postLoad(() => creditCardRepository.getCards());
  }

  CreditCard getSelectedCard() {
    return _selectedCard.value;
  }

  void setDefault() async {
    await creditCardRepository.setDefault(getSelectedCard());
    cards.postLoad(() => creditCardRepository.getCards());
  }

}