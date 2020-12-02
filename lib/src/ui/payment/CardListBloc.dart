/*
* Created to flutter-components at 05/20/2020
*/
import "dart:developer" as dev;

import 'package:data/local/entity/CreditCard.dart';
import 'package:data/repository/CreditCardRepository.dart';
import 'package:flutter_useful_things/base/BaseBloc.dart';
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:flutter_useful_things/livedata/MutableResponseStream.dart';
import 'package:flutter_useful_things/livedata/ResponseStream.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CardListBloc extends BaseBloc {

  CreditCardRepository creditCardRepository = inject();
  MutableResponseStream<List<CreditCard>> _cards = MutableResponseStream();
  ResponseStream<List<CreditCard>> get cards => _cards.observable;


  BehaviorSubject<CreditCard> _selectedCard = BehaviorSubject();
  ValueStream<CreditCard> get selectedCard => _selectedCard.stream;

  void refreshCards() {
    _cards.postLoad(() => creditCardRepository.refreshCards(),
      onError: (data) {
        _cards.postLoad(() => creditCardRepository.getCards());
      },
    );
  }

  void selectCardByPosition(int index) {
    _selectedCard.add(_cards.getSyncValue()[index]);
  }

  void removeCard() async {
    await creditCardRepository.removeCard(_selectedCard.value..isRemoved = true);
    _cards.postLoad(() => creditCardRepository.getCards());
  }

  CreditCard getSelectedCard() {
    return _selectedCard.value;
  }

  void setDefault() async {
    await creditCardRepository.setDefault(getSelectedCard());
    _cards.postLoad(() => creditCardRepository.getCards());
  }

  void deleteRemoved() async {
    creditCardRepository.deleteRemoved();
  }

  @override
  void close() {
    _cards.close();
    _selectedCard.close();
  }

}