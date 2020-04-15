
import 'package:flutter/material.dart';

import 'TextStyles.dart';

class Hyperlink extends StatelessWidget {
  Hyperlink(
    this.data, {
        this.onPress,
        this.theme,
        this.wrapAlignment
    }
  );

  final String data;
  final HyperlinkTheme theme;
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
            child: Text(data, style: theme?.textStyle ?? null)
          ),
        )
      ],
    );
  }

}

class HyperlinkTheme {
  HyperlinkTheme(this.textStyle);

  static HyperlinkTheme loginTheme = HyperlinkTheme(
    TextStyle(
      color: Colors.black,
      fontSize: 18
    )
  );

  static HyperlinkTheme poppinsMedium = HyperlinkTheme(
    TextStyles.poppinsMedium
  );

  final TextStyle textStyle;

}