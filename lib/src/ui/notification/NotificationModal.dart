/*
* Created to flutter-components at 05/16/2020
*/
import "dart:developer" as dev;

import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/backgrounds/BackgroundActionSheet.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/utils/Functions.dart';

class NotificationModal extends StatefulWidget {
  NotificationModal(this.context, {this.onSuccess});

  final BuildContext context;
  final Function onSuccess;

  void show(){
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        builder: (context) {
          return this;
        }
    );
  }

  @override
  _NotificationModalState createState() => _NotificationModalState();

}

class _NotificationModalState extends State<NotificationModal> {

  @override
  Widget build(BuildContext context) {

    double height = heightByPercent(context, 30);

    return BackgroundActionSheet(
      constraints: BoxConstraints(minHeight: 370),
      padding: const EdgeInsets.all(20),
      height: height,
      child: Text(Strings.strings["empty_notification"], style: TextStyles.titleBlack, textAlign: TextAlign.center,)
    );
  }

}