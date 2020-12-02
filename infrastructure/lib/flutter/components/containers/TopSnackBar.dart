import 'package:flutter/material.dart';
import 'package:flutter_useful_things/components/textviews/TextStyles.dart';

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
            bottom: false,
            child: Material(
              color: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
