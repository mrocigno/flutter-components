
import 'package:data/local/db/DaoBase.dart';
import 'package:data/local/entity/User.dart';
import 'package:data/mapper/UserMapper.dart';
import 'package:flutter_useful_things/di/Injection.dart';

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
        "photoPath TEXT, "
        "logged INTEGER, "
        "token TEXT"
      ")";

  @override
  UserMapper get mapper => inject();

  Future<User> getSession() async {
    var user = await db.query(tableName,
      where: "logged = 1"
    );
    if(user.length > 0) return mapper.fromDataMap(user[0]);
    return null;
  }

  void closeSession() {
    db.delete(tableName,
      where: "logged = 1"
    );
  }

}