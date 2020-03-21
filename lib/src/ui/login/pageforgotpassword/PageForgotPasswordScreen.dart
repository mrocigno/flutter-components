import 'package:infrastructure/flutter/components/Background.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/Input.dart';
import 'package:infrastructure/flutter/components/MopeiButton.dart';
import 'package:mopei_app/src/ui/login/HomeLoginScreen.dart';
import 'package:mopei_app/src/ui/login/pageforgotpassword/PageForgotPasswordBloc.dart';

class PageForgotPasswordScreen extends StatelessWidget {
  PageForgotPasswordScreen({this.navigationPage});

  final CustomPageController navigationPage;
  final pageForgotPasswordBloc = PageForgotPasswordBloc();

  @override
  Widget build(BuildContext context) {
    return Background(
      theme: BackgroundTheme.loginPage,
      showDrawer: false,
      title: "Esqueci a senha",
      onNavigationClick: () {
        navigationPage.navigateTo(1);
      },
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
//                  Input(InputThemes.whiteBackground,
//                    hint: "E-mail",
//                    margin: EdgeInsets.only(top: 10),
//                    stream: pageForgotPasswordBloc.emailStream,
//                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: MopeiButton(MopeiButtonTheme.mainTheme,
              text: "enviar",
              isLoading: pageForgotPasswordBloc.isLoading,
              onTap: () => pageForgotPasswordBloc.createAccount(),
            ),
          )
        ],
      ),
    );
  }

}