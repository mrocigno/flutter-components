import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';

class TopSnackBar extends StatelessWidget {

  final Widget child;
  final bool autoClose;
  final Function onClickCloseButton;

  TopSnackBar({
    this.child,
    this.autoClose = true,
    this.onClickCloseButton
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          color: Colors.blueGrey,
          width: double.infinity,
          child: SafeArea(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: child),
                      IconButton(icon: Icon(Icons.close, color: Colors.white), onPressed: onClickCloseButton)
                    ],
                  ),
                ),
              )
          ),
        )
      ],
    );
  }
}
