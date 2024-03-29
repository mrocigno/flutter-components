/*
* Created to flutter-components at 05/12/2020
*/
import "dart:developer" as dev;

import 'package:data/local/entity/User.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';

class UserMapper extends Mapper<User> {

  @override
  User fromRemoteMap(Map<String, Object> input) => User(
      id: input["id"],
      name: input["name"],
      email: input["email"],
      gender: input["gender"],
      phone: input["phone"],
      photoPath: input["photoPath"],
      token: input["token"]
  );

  @override
  User fromDataMap(Map<String, Object> input) => User(
    id: input["id"],
    name: input["name"],
    email: input["email"],
    gender: input["gender"],
    phone: input["phone"],
    photoPath: input["photoPath"],
    logged: input["logged"] == 1,
    token: input["token"]
  );

  @override
  Map<String, Object> toDataMap(User input) => {
    "id": input.id,
    "name": input.name,
    "email": input.email,
    "gender": input.gender,
    "phone": input.phone,
    "photoPath": input.photoPath,
    "logged": input.logged? 1 : 0,
    "token": input.token
  };

}