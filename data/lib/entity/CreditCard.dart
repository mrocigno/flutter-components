/*
* Created to flutter-components at 05/17/2020
*/
import "dart:developer" as dev;

class CreditCard {

  String number;
  String expireData;
  String cvv;
  String cardHolderName;

  CreditCard({
    this.cardHolderName,
    this.cvv,
    this.expireData,
    this.number
  });

}