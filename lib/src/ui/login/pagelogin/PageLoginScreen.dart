import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/Hyperlink.dart';
import 'package:infrastructure/flutter/components/Input.dart';
import 'package:infrastructure/flutter/components/MopeiButton.dart';
import 'package:mopei_app/src/ui/login/HomeLoginScreen.dart';
import 'package:mopei_app/src/ui/login/pagelogin/PageLoginBloc.dart';

class PageLoginScreen extends StatelessWidget {
  PageLoginScreen({this.navigationPage});

  final CustomPageController navigationPage;
  final PageLoginBloc pageLoginBloc = PageLoginBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Input(InputThemes.blackBackground,
            hint: "E-mail",
            margin: EdgeInsets.only(top: 20),
            stream: pageLoginBloc.emailStream
          ),
          Input(InputThemes.blackBackground,
            hint: "Senha",
            margin: EdgeInsets.only(top: 20)
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: MopeiButton(MopeiButtonTheme.mainTheme,
              text: "Entrar",
              isLoading: pageLoginBloc.isLoading,
              onTap: () {
                pageLoginBloc.doLogin();
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
                    onPress: () => navigationPage.navigateTo(0)
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Hyperlink("Criar conta",
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