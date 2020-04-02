import 'dart:async';

import 'package:domain/entity/Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:infrastructure/flutter/components/TextStyles.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/utils/AnimationsUtils.dart';

class CardHighlight extends StatelessWidget {

  final Item model;

  CardHighlight({
    this.model
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: 250,
        height: 350,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.network(model.mainImageUrl,
                    alignment: Alignment.center,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Material(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: BumpAnimated(
                        child: (controller, animation) {
                          StreamController<bool> active = StreamController();
                          active.onCancel = (){
                            active.close();
                          };
                          return ScaleTransition(
                            scale: animation,
                            child: StreamBuilder(
                              stream: active.stream,
                              initialData: model.favorite,
                              builder: (context, activeResp) => IconButton(
                                icon: (activeResp.data?
                                  Icon(Icons.star, color: Colors.amber) :
                                  Icon(Icons.star_border)
                                ),
                                onPressed: (){
                                  if(activeResp.data) controller.reverse();
                                  else controller.forward();
                                  model.favorite = !activeResp.data;
                                  active.add(!activeResp.data);
                                },
                              ),
                            )
                          );
                        }
                      )
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    height: 1,
                    color: Constants.Colors.BLACK_TRANSPARENT,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.name, style: TextStyles.titleBlack),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5, bottom: 5),
                              child: Text("R\$"),
                            ),
                            Text("${model.value}", style: TextStyle(fontSize: 30),)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
