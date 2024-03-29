import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:infrastructure/flutter/utils/Functions.dart';

class Background extends StatelessWidget{
  Background({
    Key key,
    this.child,
    this.title,
    this.showDrawer = false,
    this.theme,
    this.onNavigationClick,
    this.actions,
    this.bottomNavigation,
    this.onWillPop,
    this.bottomSheet,
    this.floatingActionButton,
    this.centerTitle = true
  }) : super(key: key);

  final bool centerTitle;
  final Widget child;
  final Widget title;
  final Widget bottomSheet;
  final bool showDrawer;
  final Function onNavigationClick;
  final List<AppBarAction> actions;
  final Widget bottomNavigation;
  final BackgroundTheme theme;
  final WillPopCallback onWillPop;
  final FloatingActionButton floatingActionButton;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    BackgroundTheme _theme = theme ?? BackgroundTheme.main;

    Widget leading;
    if (showDrawer) {
      leading = IconButton(
        icon: Image.asset("assets/img/icMenu.png",
          width: 24,
          height: 24,
        ),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      );
    } else if (onNavigationClick != null) {
      leading = IconButton(
        icon: Icon(Icons.arrow_back, color: _theme.titleColor),
        onPressed: onNavigationClick,
      );
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: _theme.decoration,
            clipBehavior: Clip.hardEdge,
          ),
          Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            bottomNavigationBar: bottomNavigation,
            resizeToAvoidBottomInset: false,
            floatingActionButton: floatingActionButton,
            appBar: AppBar(
              centerTitle: centerTitle,
              iconTheme: IconThemeData(color: _theme.titleColor),
              textTheme: TextTheme(headline6: TextStyle(color: _theme.titleColor, fontSize: 20, fontFamily: "lato")),
              title: title,
              backgroundColor: Colors.transparent,
              brightness: Brightness.dark,
              elevation: 0,
              leading: leading,
              actions: actions,
            ),
            body: child,
            drawer: (showDrawer?
              Drawer(
                child: Container(
                  color: Colors.red,
                ),
              ) : null
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundTheme {

  static BackgroundTheme main = BackgroundTheme(
    titleColor: Colors.white,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Constants.Colors.GRADIENT_BACKGROUND_INI,
          Constants.Colors.GRADIENT_BACKGROUND_END
        ]
      )
    )
  );

  static BackgroundTheme details = BackgroundTheme(
    titleColor: Constants.Colors.COLOR_PRIMARY,
    decoration: BoxDecoration(
      color: Constants.Colors.BACKGROUND_WHITE
    )
  );

  static BackgroundTheme test = BackgroundTheme(
    titleColor: Constants.Colors.COLOR_PRIMARY,
    decoration: BoxDecoration(
      color: Colors.transparent
    )
  );

  static BackgroundTheme loginPage = BackgroundTheme(
    titleColor: Colors.black,
    decoration: BoxDecoration(
//      color: Constants.Colors.BLACK_TRANSPARENT,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20)
        )
    )
  );

  BackgroundTheme({this.decoration, this.titleColor});

  final BoxDecoration decoration;
  final Color titleColor;
}

class AppBarAction extends StatelessWidget{

  final Icon icon;
  final String imgPath;
  final Function onTap;

  AppBarAction({this.imgPath, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) => IconButton(
    icon: (icon != null? icon : Image.asset(imgPath,
      width: 24,
      height: 24,
    )),
    onPressed: onTap,
  );
}