import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:flutter/services.dart';

class Strings {

  static const String _DEFAULT_LOCALE = "pt_BR";
  static const List<String> _SUPPORTED_LOCALES = [
    "pt_BR"
  ];

  static Map<String, dynamic> strings;

  static String getPlural(String key, int plural){
    Map pluralMap = strings[key];
    String pluralKey = plural > 1? "other":"one";
    return pluralMap[pluralKey];
  }

  static Future<void> initialize() async {
    String localeName = Platform.localeName;
    if(!_SUPPORTED_LOCALES.contains(localeName)){
      localeName = _DEFAULT_LOCALE;
    }
    String stringsJson = await rootBundle.loadString("assets/strings/$localeName.json");
    strings = json.decode(stringsJson);
  }
}