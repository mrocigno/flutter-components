import 'package:data/entity/Category.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/components/TabView.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:mopei_app/src/ui/main/home/HomeBloc.dart';

class PageCategories extends TabChild {

  @override
  String get title => Strings.strings["home_page_2"];

  @override
  StatelessWidget get child => _PageCategories();

}

class _PageCategories extends StatelessWidget {

  final HomeBloc bloc = sharedBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: StreamBuilder<List<Category>>(
        stream: bloc.categories,
        builder: (context, snapshot) {
          return Container(
            child: GridView.count(
              padding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
              crossAxisCount: 3,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: snapshot.data?.map((category) {
                return Container(
                  margin: EdgeInsets.only(right: 20, bottom: 20),
                  alignment: Alignment.center,
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    elevation: 5,
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Image.asset("assets/img/icCategoryHelm.png"),
                              )
                          ),
                          Text(category.name, style: TextStyles.poppinsMedium)
                        ],
                      ),
                    ),
                  ),
                );
              })?.toList() ?? [Container()],
            ),
          );
        },
      ),
    );
  }



}