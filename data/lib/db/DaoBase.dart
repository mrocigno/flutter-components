import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';
import 'package:sqflite/sqflite.dart';

abstract class DaoBase {

  String get tableName;

  String get sqlCreate;

  Mapper get mapper;

  Database db;

}