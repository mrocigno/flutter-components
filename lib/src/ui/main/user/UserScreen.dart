import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("User", style: TextStyles.poppinsMedium),
    );
  }
}