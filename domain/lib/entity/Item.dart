import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class Item {

  int id;
  int remoteId;
  String mainImageUrl;
  String name;
  double value;
  bool favorite;

  Item({
    this.id,
    this.remoteId,
    this.mainImageUrl = "",
    this.value = 0.0,
    this.name = "",
    this.favorite = false
  });

}