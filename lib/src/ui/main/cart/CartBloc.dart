import 'dart:developer' as dev;

import 'package:data/repository/CartRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';

class CartBloc extends BaseBloc {

  final CartRepository cartRepository;

  CartBloc({
    @required this.cartRepository
  });

}