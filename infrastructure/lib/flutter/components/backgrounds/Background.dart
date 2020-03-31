import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/HomeBottomNavigationBar.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;

class Background extends StatelessWidget{
  Background({
    Key key,
    this.child,
    this.title = "",
    this.showDrawer = false,
    this.theme,
    this.onNavigationClick,
    this.actions,
    this.bottomNavigation,
  }) : super(key: key);

  final Widget child;
  final String title;
  final bool showDrawer;
  final Function onNavigationClick;
  final List<AppBarAction> actions;
  final Widget bottomNavigation;
  final BackgroundTheme theme;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  final GlobalKey _titleKey = GlobalKey();
  GlobalKey get titleKey => _titleKey;

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

    return Stack(
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
          appBar: AppBar(
            centerTitle: _theme.centralizeTitle,
            title: Text(title,
              key: _titleKey,
              style: TextStyle(
                  color: _theme.titleColor
              ),
            ),
            backgroundColor: Colors.transparent,
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
    );
  }
}

class BackgroundTheme {

  static BackgroundTheme main = BackgroundTheme(
    centralizeTitle: true,
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

  static BackgroundTheme loginPage = BackgroundTheme(
    centralizeTitle: false,
    titleColor: Colors.black,
    decoration: BoxDecoration(
//      color: Constants.Colors.BLACK_TRANSPARENT,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20)
        )
    )
  );

  BackgroundTheme({this.decoration, this.centralizeTitle, this.titleColor});

  final BoxDecoration decoration;
  final bool centralizeTitle;
  final Color titleColor;
}

class AppBarAction extends StatelessWidget{

  final String imgPath;
  final Function onTap;

  AppBarAction({this.imgPath, this.onTap});

  @override
  Widget build(BuildContext context) => IconButton(
    icon: Image.asset(imgPath,
      width: 24,
      height: 24,
    ),
    onPressed: onTap,
  );
}