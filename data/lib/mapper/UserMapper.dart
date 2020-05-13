/*
* Created to flutter-components at 05/12/2020
*/
import "dart:developer" as dev;

import 'package:data/entity/User.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';

class UserMapper extends Mapper<User> {
  @override
  User fromDataMap(Map<String, Object> input) => User(
    id: input["id"],
    name: input["name"],
    email: input["email"],
    gender: input["gender"],
    phone: input["phone"],
    photoPath: input["photoPath"]
  );

  @override
  User fromResponse(Map<String, Object> input) => User(
      id: input["id"],
      name: input["name"],
      email: input["email"],
      gender: input["gender"],
      phone: input["phone"],
      photoPath: input["photoPath"]
  );

  @override
  Map<String, Object> toDataMap(User input) => {
    "id": input.id,
    "name": input.name,
    "email": input.email,
    "gender": input.gender,
    "phone": input.phone,
    "photoPath": input.photoPath
  };

}