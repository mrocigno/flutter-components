import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:infrastructure/flutter/components/BackgroundLogin.dart';
import 'package:infrastructure/flutter/base/BaseScreen.dart';
import 'package:mopei_app/src/ui/login/pagecreateaccount/PageCreateAccountScreen.dart';
import 'package:mopei_app/src/ui/login/pagelogin/PageLoginScreen.dart';

class HomeLoginScreen extends BaseScreen {

  @override
  Widget build(BuildContext context) {

    int page = 1;
    final navigationPage = CustomPageController(page);

    return BackgroundLogin(
      child: WillPopScope(
        onWillPop: () async {
//          if(page == 0 || page == 2){
            await navigationPage.navigateTo(1);
            return false;
//          }
//          return true;
        },
        child: PageView(
          onPageChanged: (index) {
            page = index;
          },
          controller: navigationPage,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              color: Colors.blue,
            ),
            PageLoginScreen(
              navigationPage: navigationPage,
            ),
            PageCreateAccountScreen(
              navigationPage: navigationPage,
            )
          ],
        )
      )
    );
  }
}

class CustomPageController extends PageController {

  CustomPageController(int initialPage) : super(initialPage :initialPage);

  Future<void> navigateTo(int page) async {
    this.animateToPage(page, duration: Duration(milliseconds: 700), curve: Curves.easeInQuart);
  }

}