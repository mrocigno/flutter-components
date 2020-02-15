
import 'package:flutter/material.dart';

class Hyperlink extends StatelessWidget {
  Hyperlink(
    this.data, {
        this.onPress,
        this.theme
    }
  );

  final String data;
  final HyperlinkTheme theme;
  final onPress;

  @override
  Widget build(BuildContext context) {
    return Wrap(
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
      color: Colors.white,
      fontSize: 18
    )
  );

  final TextStyle textStyle;

}