/*
* Created to flutter-components at 05/12/2020
*/
import "dart:developer" as dev;

class User {

  int id;
  String email;
  String name;
  String phone;
  int gender;
  String photoPath;
  bool logged;
  String token;

  User({
    this.id,
    this.email,
    this.name,
    this.gender,
    this.phone,
    this.photoPath,
    this.logged,
    this.token
  });

}