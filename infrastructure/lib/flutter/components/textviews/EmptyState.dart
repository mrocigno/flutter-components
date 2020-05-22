/*
* Created to flutter-components at 05/21/2020
*/
import "dart:developer" as dev;

import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/textviews/Hyperlink.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';

class EmptyState extends StatefulWidget {

  final IconData icon;
  final Color iconColor;
  final String title;
  final TextStyle titleStyle;
  final String hyperlink;
  final TextStyle hyperlinkStyle;
  final Function onHyperlinkPressed;

  EmptyState({
    this.title = "",
    this.titleStyle = TextStyles.title2White,
    this.icon = Icons.hourglass_empty,
    this.iconColor = Colors.white,
    this.hyperlink = "",
    this.hyperlinkStyle = TextStyles.subtitleWhite,
    this.onHyperlinkPressed
  });

  @override
  _EmptyStateState createState() => _EmptyStateState();

}

class _EmptyStateState extends State<EmptyState> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      children: <Widget>[
        Icon(widget.icon, color: widget.iconColor, size: 150),
        Text(widget.title, style: widget.titleStyle),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Hyperlink(widget.hyperlink,
            style: widget.hyperlinkStyle,
            onPress: widget.onHyperlinkPressed,
          ),
        )
      ],
    );
  }
}
