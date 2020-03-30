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

    return Column(
      children: <Widget>[
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Criar conta",
            style: TextStyle(
                color: Colors.black
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: FormValidate(
              padding: EdgeInsets.symmetric(horizontal: 20),
              key: formKey,
              child: Column(
                children: <Widget>[
                  Input(InputThemes.loginTheme,
                    hint: "E-mail",
                    margin: EdgeInsets.only(top: 20),
                    controller: emailController,
                  ),
                  Input(InputThemes.loginTheme,
                    hint: "Telefone",
                    margin: EdgeInsets.only(top: 20),
                    controller: phoneController,
                  ),
                  Input(InputThemes.loginTheme,
                    hint: "Senha",
                    margin: EdgeInsets.only(top: 20),
                    controller: passwordController,
                    obscureText: true,
                  ),
                  Input(InputThemes.loginTheme,
                    hint: "Confirme a senha",
                    margin: EdgeInsets.only(top: 20),
                    controller: confirmPasswordController,
                    obscureText: true,
                  )
                ],
              ),
            )
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
    );
  }

}