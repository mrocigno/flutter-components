/*
* Created to flutter-components at 05/17/2020
*/
import "dart:developer" as dev;

class CreditCard {

  int id;
  String placeHolder;
  String cardHolderName;
  String entityFlag;
  bool isDefault;
  bool isRemoved;

  CreditCard({
    this.id,
    this.placeHolder,
    this.cardHolderName,
    this.entityFlag,
    this.isDefault = false,
    this.isRemoved = false
  });

}