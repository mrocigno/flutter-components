import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as dev;
import 'package:flutter_useful_things/components/backgrounds/BackgroundActionSheet.dart';
import 'package:core/constants/Colors.dart' as Constants;
import 'package:flutter_useful_things/components/inputs/InputText.dart';
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:flutter_useful_things/utils/Functions.dart';
import 'package:mopei_app/main.dart';
import 'package:mopei_app/src/ui/login/pagecreateaccount/PageCreateAccountScreen.dart';
import 'package:mopei_app/src/ui/login/pageforgotpassword/PageForgotPasswordScreen.dart';
import 'package:mopei_app/src/ui/login/pagelogin/PageLoginBloc.dart';
import 'package:mopei_app/src/ui/login/pagelogin/PageLoginScreen.dart';

class LoginModal extends StatefulWidget {
  LoginModal(this.context, {this.onSuccess});

  final BuildContext context;
  final Function onSuccess;

  void show(){
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return this;
      }
    );
  }

  @override
  _LoginModalState createState() => _LoginModalState();

}

class CustomPageController extends PageController {

  CustomPageController(int initialPage) : super(initialPage :initialPage);

  Future<void> navigateTo(int page) async {
    this.animateToPage(page, duration: Duration(milliseconds: 700), curve: Curves.easeInQuart);
  }

}

class _LoginModalState extends State<LoginModal> {

  int page = 1;
  CustomPageController navigationPage;
  PageLoginBloc loginBloc = bloc();

  @override
  void initState() {
    super.initState();
    navigationPage = CustomPageController(page);
    loginBloc.user.observeSuccess((data) {
      widget.onSuccess?.call();
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    navigationPage.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double height = heightByPercent(context, 50);

    return BackgroundActionSheet(
        constraints: BoxConstraints(minHeight: 370),
        height: height,
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
  }

}