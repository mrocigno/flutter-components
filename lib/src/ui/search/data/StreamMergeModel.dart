/*
* Created to flutter-components at 05/31/2020
*/
import "dart:developer" as dev;

import 'package:data/local/entity/Product.dart';

class StreamMergeModel {

  List<Product> success;
  bool empty;
  Exception error;
  bool typing;

  StreamMergeModel({
    this.success,
    this.empty,
    this.error,
    this.typing
  });

  bool get isSearching => (success == null && empty == null && error == null) || typing;

  bool get isError => error != null;

  bool get isEmpty => empty != null && empty;

  bool get isSuccess => success != null && !empty;

}