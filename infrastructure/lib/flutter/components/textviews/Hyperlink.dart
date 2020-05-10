
import 'package:flutter/material.dart';

import 'TextStyles.dart';

class Hyperlink extends StatelessWidget {
  Hyperlink(
    this.data, {
      this.onPress,
      this.style,
      this.wrapAlignment
    }
  );

  final String data;
  final TextStyle style;
  final onPress;
  final WrapAlignment wrapAlignment;


  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: wrapAlignment ?? WrapAlignment.start,
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPress,
            child: Text(data, style: style)
          ),
        )
      ],
    );
  }
}