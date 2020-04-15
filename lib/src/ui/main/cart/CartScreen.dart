import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';
import 'package:infrastructure/flutter/components/backgrounds/Background.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:mopei_app/src/di/Injection.dart';
import 'package:mopei_app/src/ui/main/cart/CartBloc.dart';
import 'package:mopei_app/src/ui/main/home/HomeBloc.dart';

class CartScreen extends StatelessWidget {

  final CartBloc bloc = Injection.inject();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Teste", style: TextStyles.poppinsMedium,),
    );
  }
}