import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/components/TabView.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';

class PageCategories extends TabChild {

  @override
  String get title => Strings.strings["home_page_2"];

  @override
  Widget get child => Container(
    color: Colors.green,
  );

}