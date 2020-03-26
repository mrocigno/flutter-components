import 'package:infrastructure/flutter/components/Background.dart';
import 'package:infrastructure/flutter/components/inputs/InputController.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/inputs/InputText.dart';
import 'package:infrastructure/flutter/components/MopeiButton.dart';
import 'package:mopei_app/src/ui/login/LoginModal.dart';
import 'package:mopei_app/src/ui/login/pageforgotpassword/PageForgotPasswordBloc.dart';

class PageForgotPasswordScreen extends StatelessWidget {
  PageForgotPasswordScreen({this.navigationPage});

  final CustomPageController navigationPage;
  final pageForgotPasswordBloc = PageForgotPasswordBloc();

  final InputController emailController = InputController(
    validateBuild: (wrapper) {
      wrapper.isEmail("Email inválido");
      wrapper.required("Informe o email");
    },
  );

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
                  Input(InputThemes.whiteBackground,
                    hint: "E-mail",
                    keyboardType: TextInputType.emailAddress,
                    margin: EdgeInsets.only(top: 10),
                    controller: emailController,
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: MopeiButton(MopeiButtonTheme.mainTheme,
              text: "enviar",
              isLoading: pageForgotPasswordBloc.isLoading,
              onTap: () {
                if(emailController.validate()){
                  pageForgotPasswordBloc.changePassword();
                }
              },
            ),
          )
        ],
      ),
    );
  }

}