
import 'package:data/db/DaoBase.dart';
import 'package:data/entity/User.dart';
import 'package:data/mapper/UserMapper.dart';
import 'package:infrastructure/flutter/di/Injection.dart';

class UserDao extends DaoBase<User> {

  @override
  String get tableName => "user";

  @override
  String get sqlCreate => "CREATE TABLE $tableName ("
        "id INTEGER PRIMARY KEY, "
        "email TEXT, "
        "name TEXT, "
        "phone TEXT, "
        "gender INTEGER, "
        "photoPath TEXT"
      ")";

  @override
  UserMapper get mapper => inject();


}