import 'package:domain/entity/Category.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/components/TabView.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:mopei_app/src/di/Injection.dart';
import 'package:mopei_app/src/ui/home/HomeBloc.dart';

class PageCategories extends TabChild {

  HomeBloc bloc = Injection.inject();

  @override
  String get title => Strings.strings["home_page_2"];

  @override
  Widget get child {
//    return Container(color: Colors.red);
    return SingleChildScrollView(
      child: Container(
        height: 360,
        width: double.maxFinite,
        child: StreamBuilder<List<Category>>(
          stream: bloc.categories,
          builder: (context, snapshot) {
            return ListView.builder(
              padding: EdgeInsets.only(left: 10, top: 20, bottom: 10),
              itemCount: snapshot.data?.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.only(right: 20),
                    alignment: Alignment.center,

                );
              },
            );
          },
        ),
      ),
    );
  }

}