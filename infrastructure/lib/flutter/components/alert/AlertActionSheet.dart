/*
* Created to flutter-components at 05/14/2020
*/
import "dart:developer" as dev;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_useful_things/components/alert/AlertConfig.dart';
import 'package:flutter_useful_things/components/backgrounds/BackgroundActionSheet.dart';
import 'package:flutter_useful_things/components/buttons/MopeiButton.dart';
import 'package:flutter_useful_things/components/textviews/Hyperlink.dart';
import 'package:flutter_useful_things/components/textviews/TextStyles.dart';
import 'package:flutter_useful_things/utils/Functions.dart';

class AlertActionSheet {

  final BuildContext context;
  final AlertConfig alertConfig;

  AlertActionSheet(this.context, {@required this.alertConfig});

  void show(){
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      isDismissible: alertConfig.dismissible,
      context: context,
      builder: (context) {
        return BackgroundActionSheet(
          padding: const EdgeInsets.all(20),
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(alertConfig.title, style: TextStyles.titleBlack),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(alertConfig.text, style: TextStyles.body),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      (alertConfig.thirdButton != null? (
                        Expanded(
                          flex: 1,
                          child: Hyperlink(alertConfig.thirdButton.text,
                            wrapAlignment: WrapAlignment.center,
                            onPress: () {
                              alertConfig.thirdButton.onPress?.call();
                              if(alertConfig.closeWhenSelect) Navigator.pop(context);
                            },
                          ),
                        )
                      ) : Wrap()),
                      (alertConfig.secondButton != null? (
                        Expanded(
                          flex: 1,
                          child: MopeiButton(
                            theme: MopeiButtonTheme.outlined,
                            text: alertConfig.secondButton.text,
                            onTap: () {
                              alertConfig.secondButton.onPress?.call();
                              if(alertConfig.closeWhenSelect) Navigator.pop(context);
                            },
                          ),
                        )
                      ) : Wrap()),
                      Container(width: 10),
                      (alertConfig.primaryButton != null? (
                        Expanded(
                          flex: 1,
                          child: MopeiButton(
                            theme: MopeiButtonTheme.mainTheme,
                            text: alertConfig.primaryButton.text,
                            onTap: () {
                              alertConfig.primaryButton.onPress?.call();
                              if(alertConfig.closeWhenSelect) Navigator.pop(context);
                            },
                          ),
                        )
                      ) : Wrap())
                    ],
                  ),
                )
              )
            ],
          ),
        );
      },
    );
  }
}