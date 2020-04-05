library injection;

import 'package:flutter/widgets.dart';


class Injection {

  static List<dynamic> _modules = [];

  static initialize(BuildContext context, InjectionInitializer initializer) {
    _modules.add(context);
    initializer(_modules);
  }

  static T inject<T>() {
    for(dynamic module in _modules){
      if(module is T){
        return module;
      }
    }
    throw Exception("Module not found");
  }

}

typedef InjectionInitializer = Function(List<dynamic> list);