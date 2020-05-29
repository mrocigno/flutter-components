
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhiteTable extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Material(
              color: Colors.red,
              child: InkWell(
                onTap: () => log("Yeah"),
                child: Container(
                  color: Colors.blue,
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}