
import "dart:developer" as dev;
import "package:data/dao/UserDao.dart";
import "package:data/db/Config.dart";
import 'package:data/entity/User.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/livedata/ResponseStream.dart';

class UserRepository {

  final UserLocal _local = inject();
  final UserRemote _remote = inject();

  Future<User> doLogin(String email, String password) async {
    var user = await _remote.login(email, password);
    if(user != null){
      _local.save(user..logged = true);
    }
    return user;
  }

  Future<User> getSession() {
    return _local.getSession();
  }

  void closeSession() {
    _local.closeSession();
  }

}

class UserLocal {

  UserDao _dao = Config.daoProvider();

  void save(User user) => _dao.save(user);

  Future<User> getSession() => _dao.getSession();

  void closeSession() => _dao.closeSession();

}

class UserRemote {

  Future<User> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
//        throw ErrorResponse(
//            code: 400,
//            data: null,
//            message: "message"
//        );
    return User(
        email: "user.teste@test.com",
        photoPath: "https://conteudo.imguol.com.br/c/noticias/2014/02/03/facebook-usuaria-usuario-internet-redes-sociais-privacidade-sigilo-grampo-invasao-seguranca-computador-usa-logo-logotipo-1391424452332_1920x1357.jpg",
        phone: "(11) 97627-2040",
        gender: 1,
        name: "Matheus Rocigno",
        id: 1,
        token: "dasdasdasda"
    );
  }

}
