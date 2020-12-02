import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_useful_things/components/textviews/TextStyles.dart';

class SosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("SOS", style: TextStyles.poppinsMedium),
    );
  }
}