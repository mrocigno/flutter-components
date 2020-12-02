
import "dart:developer" as dev;

import 'package:data/local/dao/SearchDao.dart';
import 'package:data/local/db/Config.dart';
import 'package:data/remote/service/AutoCompleteService.dart';
import 'package:flutter_useful_things/di/Injection.dart';

class AutoCompleteRepository {
  _Local _local = _Local();
  _Remote _remote = _Remote();

  Future<List<String>> getHistory(String search) => _local.getHistory(search);

  Future<List<String>> autoComplete(String search) => _remote.autoComplete(search);

  void saveSearch(String search) => _local.save(search);

}

class _Local {
  SearchDao _dao = Config.daoProvider();

  Future<List<String>> getHistory(String search) => _dao.getHistorySearch(search);

  void save(String search) => _dao.save(search);

}

class _Remote {

  AutoCompleteService _service = inject();

  Future<List<String>> autoComplete(String search) => _service.autoComplete(search);

}
