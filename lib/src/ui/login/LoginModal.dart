import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as dev;
import 'package:infrastructure/flutter/components/backgrounds/BackgroundLogin.dart';
import 'package:infrastructure/flutter/components/HomeBottomNavigationBar.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:infrastructure/flutter/components/inputs/InputText.dart';
import 'package:mopei_app/main.dart';
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

    BackgroundLogin modalView = BackgroundLogin(
        child: WillPopScope(
            onWillPop: () async {
              await navigationPage.navigateTo(1);
              return page == 1;
            },
            child: PageView(
              onPageChanged: (index) {
                page = index;
                MyApp.configSystemStyleUI();
              },
              controller: navigationPage,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                PageForgotPasswordScreen(navigationPage: navigationPage),
                PageLoginScreen(navigationPage: navigationPage),
                PageCreateAccountScreen(navigationPage: navigationPage)
              ],
            )
        )
    );


    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return modalView;
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