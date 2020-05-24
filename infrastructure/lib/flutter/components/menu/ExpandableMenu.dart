/*
* Created to flutter-components at 05/14/2020
*/
import "dart:developer" as dev;

import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'dart:math' as math;

import 'package:infrastructure/flutter/utils/Matrix4Utils.dart';

class ExpandableMenu extends StatefulWidget {

  final List<ExpandableMenuItem> menus;
  final Color backgroundColor;

  ExpandableMenu({
    this.menus = const <ExpandableMenuItem>[],
    this.backgroundColor = Constants.Colors.BLACK_TRANSPARENT_LOW
  });

  @override
  ExpandableMenuState createState() => ExpandableMenuState();

}

class ExpandableMenuItem {

  final Widget icon;
  final bool initExpanded;
  final String title;
  final Widget arrowIcon;
  final Color titleColor;
  final List<ExpandableItem> items;

  ExpandableMenuItem({
    @required this.icon,
    @required this.title,
    this.titleColor = Colors.white,
    this.items = const <ExpandableItem>[],
    this.arrowIcon = const Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 30),
    this.initExpanded = false
  });

}

class ExpandableItem {

  final Widget icon;
  final String title;
  final bool show;
  final bool closeOnPress;
  final Function onPress;

  ExpandableItem({
    @required this.icon,
    @required this.title,
    @required this.onPress,
    this.closeOnPress = true,
    this.show = true
  });

}

class ExpandableMenuState extends State<ExpandableMenu> with TickerProviderStateMixin {

  List<AnimationController> listControllers = [];

  @override
  void dispose() {
    super.dispose();
    listControllers.forEach((element) => element.dispose());
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: List.generate(widget.menus.length, (index) {

        var menu = widget.menus[index];
        var controller = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
        listControllers.add(controller);
        Animation<double> size = Tween(begin: 0.0, end: 70.0).animate(controller);
        Animation<double> rotation = Tween(begin: 0.0, end: math.pi).animate(controller);

        var expanded = menu.initExpanded;
        if(menu.initExpanded){
          controller.value = 70;
        }

        return Container(
          color: widget.backgroundColor,
          child: Column(
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (!expanded) {
                      controller.forward();
                      expanded = true;
                    } else {
                      controller.reverse();
                      expanded = false;
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            menu.icon,
                            Container(width: 10),
                            Expanded(child: Text(menu.title, style: TextStyle(
                              color: menu.titleColor,
                              fontSize: 20,
                            ))),
                            AnimatedBuilder(
                              animation: rotation,
                              builder: (context, child) => Container(
                                child: menu.arrowIcon,
                                transform: Matrix4Utils.rotateByCenter(30, rotation.value),
                              ),
                            )
                          ],
                        ),
                      ]
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: size,
                builder: (context, child) => Column(
                  children: List.generate(menu.items.length, (index) {
                    var item = menu.items[index];
                    if(!item.show) return Wrap();
                    return Container(
                      height: size.value,
                      padding: const EdgeInsets.all(10),
                      child: Material(
                        elevation: 1,
                        clipBehavior: Clip.hardEdge,
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: InkWell(
                          onTap: () {
                            if(item.closeOnPress) {
                              controller.reverse();
                              expanded = false;
                            }
                            item.onPress?.call();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 10,
                              children: <Widget>[
                                item.icon,
                                Text(item.title, style: TextStyles.subtitleBlack)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                )
              )
            ],
          ),
        );
      })
    );
  }

}