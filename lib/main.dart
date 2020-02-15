import 'package:flutter/material.dart';
import 'package:mopei_app/src/ui/login/HomeLoginScreen.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    Stetho.initialize();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeLoginScreen(),
    );
  }
}