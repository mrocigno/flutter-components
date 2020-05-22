/*
* Created to flutter-components at 05/14/2020
*/
import "dart:developer" as dev;

class AlertConfig {

  final String title;
  final String text;
  final bool dismissible;
  final bool closeWhenSelect;
  final AlertButton primaryButton;
  final AlertButton secondButton;
  final AlertButton thirdButton;

  AlertConfig({
    this.title,
    this.text,
    this.dismissible = true,
    this.closeWhenSelect = true,
    this.primaryButton,
    this.secondButton,
    this.thirdButton
  });

}

class AlertButton {

  final String text;
  final Function onPress;

  AlertButton({
    this.text,
    this.onPress
  });

}