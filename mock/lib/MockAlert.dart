library mock;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MockAlert {

  final BuildContext context;

  MockAlert(this.context);

  void show(){
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          color: Colors.red,
        );
      },
    );
  }
}
