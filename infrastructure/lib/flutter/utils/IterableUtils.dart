/*
* Created to flutter-components at 05/29/2020
*/
import "dart:developer" as dev;

extension IterableUtils<T> on Iterable<T> {

  String joinString(dynamic Function(T e) function, {String separator = ","}) {
    StringBuffer buffer = StringBuffer("");
    this.forEachIndexed((element, i) {
      String append = function(element).toString();
      if (append != null) {
        buffer.write(append);
        if((length - 1) != i) buffer.write(separator);
      }
    });
    return buffer.toString();
  }

  void forEachIndexed(void Function(T e, int index) function) {
    int index = 0;
    forEach((element) {
      function(element, index++);
    });
  }

}