import 'package:infrastructure/flutter/components/Background.dart';
import 'package:infrastructure/flutter/components/inputs/FormValidate.dart';
import 'package:infrastructure/flutter/components/inputs/InputController.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/inputs/InputText.dart';
import 'package:infrastructure/flutter/components/MopeiButton.dart';
import 'package:mopei_app/src/ui/login/LoginModal.dart';
import 'package:mopei_app/src/ui/login/pagecreateaccount/PageCreateAccountBloc.dart';

// ignore: must_be_immutable
class PageCreateAccountScreen extends StatelessWidget {

  final CustomPageController navigationPage;
  final pageCreateAccountBloc = PageCreateAccountBloc();

  InputController emailController;
  InputController passwordController;
  InputController confirmPasswordController;
  InputController phoneController;

  PageCreateAccountScreen({this.navigationPage}) {
    emailController = InputController(
      validateBuild: (wrapper) {
        wrapper.isEmail("Email inválido");
        wrapper.required("Informe o email");
      },
    );

    phoneController = InputController(
      validateBuild: (wrapper) {
        wrapper.required("Informe o telefone");
      },
    );

    passwordController = InputController(
      validateBuild: (wrapper) {
        wrapper.customValidate("As senhas não coincidem", (){
          return confirmPasswordController.text == passwordController.text;
        });
        wrapper.required("Informe a senha");
      },
    );

    confirmPasswordController = InputController(
      validateBuild: (wrapper) {
        wrapper.customValidate("As senhas não coincidem", (){
          return confirmPasswordController.text == passwordController.text;
        });
        wrapper.required("Confirme a senha");
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormValidateState>();

    return Background(
      title: "Criar conta",
      theme: BackgroundTheme.loginPage,
      showDrawer: false,
      onNavigationClick: () {navigationPage.navigateTo(1);},
      child: FormValidate(
        key: formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Input(InputThemes.whiteBackground,
                      hint: "E-mail",
                      margin: EdgeInsets.only(top: 20),
                      controller: emailController,
                    ),
                    Input(InputThemes.whiteBackground,
                      hint: "Telefone",
                      margin: EdgeInsets.only(top: 20),
                      controller: phoneController,
                    ),
                    Input(InputThemes.whiteBackground,
                      hint: "Senha",
                      margin: EdgeInsets.only(top: 20),
                      controller: passwordController,
                      obscureText: true,
                    ),
                    Input(InputThemes.whiteBackground,
                      hint: "Confirme a senha",
                      margin: EdgeInsets.only(top: 20),
                      controller: confirmPasswordController,
                      obscureText: true,
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: MopeiButton(MopeiButtonTheme.mainTheme,
                text: "salvar",
                isLoading: pageCreateAccountBloc.isLoading,
                onTap: () {
                  if(formKey.currentState.validate()){
                    pageCreateAccountBloc.createAccount();
                  }
                },
              ),
            )
          ],
        ),
      )
    );
  }

}