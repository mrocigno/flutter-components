import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as Services;
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;

import 'Background.dart';
import 'BackgroundThemes.dart';

class BackgroundSliver extends StatelessWidget{
  BackgroundSliver({
    Key key,
    this.child,
    this.title = "",
    this.theme,
    this.bottomNavigation,
    this.flexibleSpaceBar,
    this.expandedHeight,
  }) : super(key: key);

  final Widget child;
  final String title;
  final double expandedHeight;
  final Widget bottomNavigation;
  final BackgroundThemes theme;
  final FlexibleSpaceBar flexibleSpaceBar;

  @override
  Widget build(BuildContext context) {
    BackgroundThemes _theme = theme ?? BackgroundThemes.details;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: _theme.decoration,
          clipBehavior: Clip.hardEdge,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: bottomNavigation,
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                brightness: Services.Brightness.light,
                floating: false,
                pinned: false,
                snap: false,
                expandedHeight: expandedHeight,
                centerTitle: _theme.centralizeTitle,
                iconTheme: IconThemeData(color: _theme.titleColor),
                title: Text(title,
                  style: TextStyle(
                      color: _theme.titleColor
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 1,
                flexibleSpace: flexibleSpaceBar,
              ),
              SliverToBoxAdapter(
                child: child,
              )
            ],
          ),
        )
      ],
    );
  }
}