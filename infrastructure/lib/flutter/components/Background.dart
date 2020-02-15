import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;

class Background extends StatelessWidget{
  Background({
    Key key,
    this.child,
    this.title = "",
    this.showDrawer = false
  }) : super(key: key);

  final Widget child;
  final String title;
  final bool showDrawer;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffKey = GlobalKey();

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Constants.Colors.GRADIENT_BACKGROUND_INI,
                Constants.Colors.GRADIENT_BACKGROUND_END
              ]
            )
          ),
        ),
        Scaffold(
          key: _scaffKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Center(child: Text(title)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              Text("aaa")
            ],
            leading: (showDrawer?
              Ink.image(image: AssetImage("assets/icMenu.png"),
                child: InkWell(
                  onTap: () => _scaffKey.currentState.openDrawer(),
                ),
              ) : null
            )
          ),
          body: child,
          drawer: (showDrawer?
            Drawer(
              child: Container(
                color: Colors.red,
              ),
            ) : null
          ),
        )
      ],
    );
  }
}

class BackgroundTheme {



}