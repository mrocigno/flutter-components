import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/inputs/FormValidate.dart';
import 'package:infrastructure/flutter/components/textviews/Hyperlink.dart';
import 'package:infrastructure/flutter/components/inputs/InputController.dart';
import 'package:infrastructure/flutter/components/inputs/InputText.dart';
import 'package:infrastructure/flutter/components/buttons/MopeiButton.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:mopei_app/src/ui/login/LoginModal.dart';
import 'package:mopei_app/src/ui/login/pagelogin/PageLoginBloc.dart';


class PageLoginScreen extends StatelessWidget {
  PageLoginScreen(this.context, {this.navigationPage, this.onSuccess});

  final BuildContext context;
  final Function onSuccess;
  final CustomPageController navigationPage;
  final PageLoginBloc pageLoginBloc = inject();

  final InputController emailController = InputController(
    validateBuild: (wrapper) {
      wrapper.isEmail("Email inválido");
      wrapper.required("Informe o email");
    },
  );
  final InputController passController = InputController(
    validateBuild: (wrapper) => wrapper.required("Informe a senha")
  );

  @override
  StatelessElement createElement() {
    pageLoginBloc.user.observeSuccess((data) {
      Navigator.pop(context);
      onSuccess?.call();
    });
    return super.createElement();
  }

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
              Strings.strings["app_name"],
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
              text: "Entrar",
              isLoading: pageLoginBloc.user.loading,
              onTap: () {
                if(formKey.currentState.validate()){
                  pageLoginBloc.doLogin(
                    email: emailController.value.text,
                    password: passController.value.text
                  );
                }
              },
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Hyperlink("Esqueceu a senha?",
                    style: TextStyles.subtitleBlack,
                    onPress: () => navigationPage.navigateTo(0)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Hyperlink(
                    "Criar conta",
                    style: TextStyles.subtitleBlack,
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
