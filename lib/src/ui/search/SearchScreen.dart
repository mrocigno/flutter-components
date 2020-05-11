/*
* Created to flutter-components at 05/10/2020
*/
import "dart:developer" as dev;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:infrastructure/flutter/base/BaseScreen.dart';
import 'package:infrastructure/flutter/components/backgrounds/BackgroundSliver.dart';
import 'package:infrastructure/flutter/components/backgrounds/BackgroundThemes.dart';
import 'package:infrastructure/flutter/components/backgrounds/CustomFlexible.dart';

class SearchScreen extends BaseScreen {

  @override
  String get name => "SearchScreen";

  @override
  Widget build(BuildContext context) {
    return BackgroundSliver(
      theme: BackgroundThemes.search,
      expandedHeight: 130,
      flexibleSpaceBar: CustomFlexible(),
      child: Container(color: Colors.blue, height: 2000,),
    );
  }

}