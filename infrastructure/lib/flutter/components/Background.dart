import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;

class Background extends StatelessWidget{
  Background({
    Key key,
    this.child,
    this.title = "",
    this.showDrawer = false,
    this.theme,
    this.onNavigationClick
  }) : super(key: key);

  final Widget child;
  final String title;
  final bool showDrawer;
  final Function onNavigationClick;
  BackgroundTheme theme;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffKey = GlobalKey();
    theme ??= BackgroundTheme.main;

    Widget leading;
    if (showDrawer) {
      leading = Ink.image(image: AssetImage("assets/icMenu.png"),
        child: InkWell(
          onTap: () => _scaffKey.currentState.openDrawer(),
        )
      );
    } else if (onNavigationClick != null) {
      leading = InkWell(
        child: Icon(Icons.arrow_back),
        onTap: onNavigationClick,
      );
    }

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: theme.decoration,
          clipBehavior: Clip.hardEdge,
        ),
        Scaffold(
          key: _scaffKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: theme.centralizeTitle,
            title: Text(title),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: leading
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

  static BackgroundTheme main = BackgroundTheme(
    BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Constants.Colors.GRADIENT_BACKGROUND_INI,
          Constants.Colors.GRADIENT_BACKGROUND_END
        ]
      )
    ),
    true
  );

  static BackgroundTheme loginPage = BackgroundTheme(
    BoxDecoration(
      color: Constants.Colors.BLACK_TRANSPARENT,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20)
      )
    ),
    false
  );

  BackgroundTheme(this.decoration, this.centralizeTitle);

  final BoxDecoration decoration;
  final bool centralizeTitle;


}