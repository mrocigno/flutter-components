import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/components/TabView.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';

class PageHighlights extends TabChild {

  @override
  Widget get child => Container(
    color: Colors.red,
  );

  @override
  String get title => Strings.strings["home_page_1"];

}