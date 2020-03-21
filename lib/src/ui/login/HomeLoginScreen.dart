import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:infrastructure/flutter/components/BackgroundLogin.dart';
import 'package:infrastructure/flutter/base/BaseScreen.dart';
import 'package:mopei_app/src/ui/login/pagecreateaccount/PageCreateAccountScreen.dart';
import 'package:mopei_app/src/ui/login/pageforgotpassword/PageForgotPasswordScreen.dart';
import 'package:mopei_app/src/ui/login/pagelogin/PageLoginScreen.dart';

class HomeLoginScreen extends BaseScreen {

  @override
  Widget build(BuildContext context) {

    int page = 1;
    final navigationPage = CustomPageController(page);

    return BackgroundLogin(
      child: WillPopScope(
        onWillPop: () async {
          await navigationPage.navigateTo(1);
          return page == 1;
        },
        child: PageView(
          onPageChanged: (index) {
            page = index;
          },
          controller: navigationPage,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            PageForgotPasswordScreen(
              navigationPage: navigationPage,
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