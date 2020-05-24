import 'package:flutter/widgets.dart';

double heightByPercent(BuildContext context, double percent){
  return MediaQuery.of(context).size.height * (percent / 100);
}

double widthByPercent(BuildContext context, double percent){
  return MediaQuery.of(context).size.width * (percent / 100);
}

double insetBottom(BuildContext context) {
  var query = MediaQuery.of(context);
  return query.viewInsets.bottom + query.padding.bottom;
}

void hideKeyboard(BuildContext context) => FocusScope.of(context).requestFocus(FocusNode());