import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/inputs/InputText.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'dart:developer' as dev;

class TabView extends StatelessWidget {

  TabView({
    this.children = const <TabChild>[],
    this.theme
  });

  final List<TabChild> children;
  final TabViewTheme theme;

  @override
  Widget build(BuildContext context) {
    TabViewTheme _theme = theme ?? TabViewTheme.homeTheme;

    return DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Padding(
              padding: _theme.padding,
              child: TabBar(
                labelColor: Colors.black,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                tabs: children.map((e) => Tab(text: e.title)).toList()
              ),
            ),
            Expanded(
              flex: 1,
              child: TabBarView(
                children: children.map((e) => e.child).toList()
              ),
            )
          ],
        )
    );
  }
}

class TabViewTheme {

  final EdgeInsetsGeometry padding;

  TabViewTheme({this.padding});

  static TabViewTheme homeTheme = TabViewTheme(
    padding: EdgeInsets.only(left: 20)
  );

}

class TabChild {

  TabChild({
    this.child,
    this.title
  });

  final String title;
  final Widget child;

}