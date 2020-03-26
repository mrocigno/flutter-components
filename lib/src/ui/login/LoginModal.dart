import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:infrastructure/flutter/components/BackgroundLogin.dart';
import 'package:mopei_app/src/ui/login/pagecreateaccount/PageCreateAccountScreen.dart';
import 'package:mopei_app/src/ui/login/pageforgotpassword/PageForgotPasswordScreen.dart';
import 'package:mopei_app/src/ui/login/pagelogin/PageLoginScreen.dart';

class LoginModal {
  LoginModal(this.context, {this.onSuccess});

  final BuildContext context;
  final Function onSuccess;

  void show(){
    int page = 1;
    final navigationPage = CustomPageController(page);
    PageForgotPasswordScreen pageForgotPassword =
      PageForgotPasswordScreen(navigationPage: navigationPage);

    PageLoginScreen pageLogin =
      PageLoginScreen(navigationPage: navigationPage);

    PageCreateAccountScreen pageCreateAccount =
      PageCreateAccountScreen(navigationPage: navigationPage);


    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {

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
                pageForgotPassword,
                pageLogin,
                pageCreateAccount
              ],
            )
          )
        );
      }
    );
  }
}

class CustomPageController extends PageController {

  CustomPageController(int initialPage) : super(initialPage :initialPage);

  Future<void> navigateTo(int page) async {
    this.animateToPage(page, duration: Duration(milliseconds: 700), curve: Curves.easeInQuart);
  }

}