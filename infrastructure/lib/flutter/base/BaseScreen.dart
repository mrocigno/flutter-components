import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BaseScreenStateful extends StatefulWidget {

  final State state;

  BaseScreenStateful(this.state);

  @override
  BaseScreen createState() => state;

}

abstract class BaseScreen extends State<BaseScreenStateful> {

  String get name;

}
