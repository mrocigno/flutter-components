import 'package:flutter/material.dart';

abstract class BaseScreen extends StatelessWidget {

  void bind<T>(Stream<T> teste, void function(T value)){
    teste.listen(function);
  }

}