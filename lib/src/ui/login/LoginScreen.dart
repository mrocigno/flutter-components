import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/Hyperlink.dart';
import 'package:infrastructure/flutter/components/BackgroundLogin.dart';
import 'package:infrastructure/flutter/components/Input.dart';
import 'package:infrastructure/flutter/components/MopeiButton.dart';
import 'package:infrastructure/flutter/base/BaseScreen.dart';
import 'package:mopei_app/src/ui/login/LoginBloc.dart';

class LoginScreen extends BaseScreen {

  final LoginBloc loginBloc = LoginBloc();


  @override
  Widget build(BuildContext context) {

    bind(loginBloc.isLoading, (value) {
      dev.log(value? "treu" : "false");
    });

    return BackgroundLogin(
      child:
    );
  }
}

class PageLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Center(
            child: Text("Mopei",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: StreamBuilder(
              stream: loginBloc.emailStream,
              builder: (context, snapshot){
                return Input(InputThemes.blackBackground,
                  hint: "e-mail",
                  model: snapshot.data,
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Input(InputThemes.blackBackground,
                hint: "senha"
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: MopeiButton(MopeiButtonTheme.mainTheme,
              text: "Entrar",
              isLoading: loginBloc.isLoading,
              onTap: () {
                loginBloc.doLogin();
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
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Hyperlink("Criar conta",
                    theme: HyperlinkTheme.loginTheme,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
  }

}