/*
* Created to flutter-components at 05/31/2020
*/
import "dart:developer" as dev;

class AutoCompleteModel {

  IconType iconType;
  String text;

  AutoCompleteModel({
    this.iconType,
    this.text
  });

}

enum IconType {
  SEARCH,
  HISTORY
}