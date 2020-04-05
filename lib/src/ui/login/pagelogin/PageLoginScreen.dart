import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/inputs/FormValidate.dart';
import 'package:infrastructure/flutter/components/Hyperlink.dart';
import 'package:infrastructure/flutter/components/inputs/InputController.dart';
import 'package:infrastructure/flutter/components/inputs/InputText.dart';
import 'package:infrastructure/flutter/components/buttons/MopeiButton.dart';
import 'package:mopei_app/src/ui/login/LoginModal.dart';
import 'package:mopei_app/src/ui/login/pagelogin/PageLoginBloc.dart';

// ignore: must_be_immutable
class PageLoginScreen extends StatelessWidget {
  PageLoginScreen({this.navigationPage});

  final CustomPageController navigationPage;
  final PageLoginBloc pageLoginBloc = PageLoginBloc();

  InputController emailController = InputController(
    validateBuild: (wrapper) {
      wrapper.isEmail("Email inválido");
      wrapper.required("Informe o email");
    },
  );
  InputController passController = InputController(
    validateBuild: (wrapper) => wrapper.required("Informe a senha")
  );

  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormValidateState>();

    return FormValidate(
      padding: EdgeInsets.all(20),
      key: formKey,
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              "Mopei",
              style: TextStyle(fontSize: 40),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Input(
                    InputThemes.loginTheme,
                    hint: "E-mail",
                    margin: EdgeInsets.only(top: 20),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Input(
                    InputThemes.loginTheme,
                    obscureText: true,
                    hint: "Senha",
                    margin: EdgeInsets.only(top: 20),
                    controller: passController,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: MopeiButton(
              MopeiButtonTheme.mainTheme,
              text: "Entrar",
              isLoading: pageLoginBloc.isLoading,
              onTap: () {
                print("${formKey.currentState.validate()}");
              },
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Hyperlink("Esqueceu a senha?",
                      theme: HyperlinkTheme.loginTheme,
                      onPress: () => navigationPage.navigateTo(0)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Hyperlink(
                    "Criar conta",
                    theme: HyperlinkTheme.loginTheme,
                    onPress: () => navigationPage.navigateTo(2),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
