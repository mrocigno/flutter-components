/*
* Created to flutter-components at 05/31/2020
*/
import "dart:developer" as dev;

import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:mopei_app/src/ui/search/data/AutoCompleteModel.dart';

class CardHistorySearch extends StatelessWidget {

  final AutoCompleteModel model;
  final Function(String selected) onPressed;

  CardHistorySearch({
    @required this.model,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    Widget icon;
    switch (model.iconType) {
      case IconType.HISTORY: icon = Icon(Icons.history, size: 20); break;
      case IconType.SEARCH: icon = Icon(Icons.search, size: 15); break;
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onPressed?.call(model.text),
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(.1)))
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                child: icon,
              ),
              Container(width: 10),
              Expanded(
                flex: 1,
                child: Text(model.text),
              )
            ],
          ),
        ),
      ),
    );
  }

}