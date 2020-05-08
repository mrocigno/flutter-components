
T inject<T>({String named}) => Injection.inject(named: named);

class Injection {

  static _ModuleConstructor _moduleConstructor = _ModuleConstructor();

  static initialize(InjectionInitializer initializer) {
    initializer(_moduleConstructor);
  }

  static T inject<T>({String named}) {
    _Module module = _getModule<T>(named: named);
    switch(module.type){
      case 1: {
        return _getSingleton(module);
      }
      case 2: {
        return module.build();
      }
      default: {
        throw Exception("Type not definied");
      }
    }
  }
  
  static _Module _getModule<T>({String named}) {
    if(named != null){
      try {
        return _moduleConstructor._modules.singleWhere((element) => element.named == named);
      } catch (e) {
        throw Exception("Module not found $named");
      }
    } else {
      try {
        return _moduleConstructor._modules.singleWhere((element) => element.typeClass == T);
      } catch (e) {
        throw Exception("Module not found $T");
      }
    }
  }

  static T _getSingleton<T>(_Module module){
    if(module.singleton == null) {
      module.singleton = module.build();
    }
    return module.singleton;
  }

}

class _Module {

  final int type;
  final Build build;
  final String named;
  final Type typeClass;
  dynamic singleton;

  _Module(this.type, this.build, this.typeClass, {this.named});

}

class _ModuleConstructor {

  final List<_Module> _modules = [];

  void singleton<T>(Build<T> build, {String named}){
    _modules.add(_Module(1, build, T,
        named: named
    ));
  }

  void factory<T>(Build<T> build, {String named}){
    _modules.add(_Module(2, build, T,
        named: named
    ));
  }

}

typedef Build<T> = T Function();
typedef InjectionInitializer = Function(_ModuleConstructor moduleConstructor);