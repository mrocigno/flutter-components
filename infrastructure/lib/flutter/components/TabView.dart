import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/inputs/InputText.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'dart:developer' as dev;

class TabView extends StatefulWidget {

  TabView({
    this.children = const <TabChild>[],
    this.theme,
    this.onPageChange,
    this.initialIndex
  });

  final List<TabChild> children;
  final TabViewTheme theme;
  final PageChange onPageChange;
  final int initialIndex;

  @override
  _TabViewState createState() => _TabViewState();

}

typedef PageChange = void Function(int page);

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin{

  TabController _controller;
  int prevPage = 0;

  @override
  void initState() {
    prevPage = widget.initialIndex ?? 0;
    _controller ??= TabController(
      length: widget.children.length,
      vsync: this,
      initialIndex: prevPage
    );
    if(widget.onPageChange != null){
      _controller.addListener(() {
        if(prevPage != _controller.index){
          widget.onPageChange(_controller.index);
        }
        prevPage = _controller.index;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabViewTheme _theme = widget.theme ?? TabViewTheme.homeTheme;

    return Column(
      children: <Widget>[
        Padding(
          padding: _theme.padding,
          child: TabBar(
            controller: _controller,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            tabs: widget.children.map((e) => Tab(text: e.title)).toList()
          ),
        ),
        Expanded(
          flex: 1,
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            children: widget.children.map((e) => e.child).toList()
          ),
        )
      ],
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