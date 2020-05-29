/*
* Created to flutter-components at 05/28/2020
*/
import "dart:developer" as dev;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MockBubble extends StatefulWidget {
  @override
  _MockBubbleState createState() => _MockBubbleState();
}

class _MockBubbleState extends State<MockBubble> {

  int active = 2;
  bool dragging = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IgnorePointer(
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: dragging? 1 : 0,
            child: Container(color: Colors.black.withOpacity(.4)),
          ),
        ),
        SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(flex: 1,
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 1,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: target(1),
                      ),
                    ),
                    Expanded(flex: 1,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: target(2),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(flex: 1,
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: target(3),
                      ),
                    ),
                    Expanded(flex: 1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: target(4),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(flex: 1,
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 1,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: target(5),
                      ),
                    ),
                    Expanded(flex: 1,
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: target(6),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget target(int id) => DragTarget(
    builder: (context, List<String> candidateData, rejectedData) {
      if(id == active){
        return bubble();
      }
      return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        transform: Matrix4.translationValues((dragging? 0 : (id % 2 == 0? 60 : -60)), 0, 0),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            color: Colors.white30,
            elevation: 2,
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Icon(Icons.extension, color: Colors.white30, size: 24),
            ),
          ),
        ),
      );
    },
    onWillAccept: (data) => true,
    onAccept: (data) => setState(() {
      active = id;
    }),
  );

  Widget bubble() {
    Widget _bubble = IgnorePointer(
      ignoring: false,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        color: Colors.amber,
        elevation: 2,
        clipBehavior: Clip.hardEdge,
        child: IconButton(
            icon: Icon(Icons.extension),
            onPressed: () => dev.log("teste")
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Draggable(
        data: "bubble",
        child: _bubble,
        feedback: _bubble,
        childWhenDragging: Wrap(),
        onDragStarted: () => setState(() {
          dragging = true;
        }),
        onDragEnd: (details) => setState(() {
          dragging = false;
        }),
      )
    );
  }

}
