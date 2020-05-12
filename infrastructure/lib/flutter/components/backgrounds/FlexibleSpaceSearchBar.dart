/*
* Created to flutter-components at 05/09/2020
*/
import "dart:developer" as dev;

import 'package:flutter/cupertino.dart';
import 'package:infrastructure/flutter/components/inputs/InputController.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/inputs/InputText.dart';

class FlexibleSpaceSearchBar extends StatefulWidget {

  final OnPerformSearch onPerformSearch;
  final String initialData;
  final Stream<bool> loadObserver;

  FlexibleSpaceSearchBar({
    Key key,
    this.onPerformSearch,
    this.initialData,
    this.loadObserver
  }) : super(key: key);

  @override
  FlexibleSpaceSearchBarState createState() => FlexibleSpaceSearchBarState();

}

typedef OnPerformSearch = Function(String search);

class FlexibleSpaceSearchBarState extends State<FlexibleSpaceSearchBar> {

  InputController _controller;
  String get searchText => _controller?.value?.text ?? "";

  @override
  void initState() {
    super.initState();
    _controller = InputController(
        text: widget.initialData
    );
  }

  @override
  Widget build(BuildContext context) {
    final FlexibleSpaceBarSettings settings = context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();

    final double deltaExtent = settings.maxExtent - settings.minExtent;

    // 1.0 -> Expanded
    // 0.0 -> Collapsed to toolbar
    final double t = (1 -(settings.currentExtent - settings.minExtent) / deltaExtent).clamp(0.0, 1.0) as double;

    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: (1 - t),
            child: Container(
              alignment: Alignment.center,
              height: 56,
              child: Text("Mopei", style: TextStyle(fontSize: 20, color: Constants.Colors.PRIMARY_SWATCH),),
            )
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(left: (50 * t), right: (50 * t)),
            child: Hero(
              tag: "SearchField",
              child: Material(
                color: Colors.transparent,
                child: Input(InputThemes.searchDarkTheme,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  controller: _controller,
                  icon: "assets/img/icSearchPurple.png",
                  onFieldSubmitted: (value) => widget.onPerformSearch?.call(value),
                  onTapIcon: (){
                    widget.onPerformSearch?.call(_controller.value.text);
                  },
                ),
              ),
            ),
          ),
          (widget.loadObserver != null? (
            Container(
              alignment: Alignment.bottomCenter,
              child: StreamBuilder<bool>(
                stream: widget.loadObserver,
                builder: (context, snapshot) {
                  if(snapshot.hasData && snapshot.data) return Container(height: 2, child: LinearProgressIndicator());
                  return Wrap();
                },
              ),
            )
          ) : (Wrap()))
        ],
      )
    );
  }

}