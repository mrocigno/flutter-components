import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/Input.dart';
import 'package:infrastructure/flutter/components/MopeiButton.dart';
import 'package:mopei_app/src/ui/login/HomeLoginScreen.dart';
import 'package:mopei_app/src/ui/login/pagecreateaccount/PageCreateAccountBloc.dart';

class PageCreateAccountScreen extends StatelessWidget {
  PageCreateAccountScreen({this.navigationPage});

  final CustomPageController navigationPage;
  final pageCreateAccountBloc = PageCreateAccountBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.Colors.BLACK_TRANSPARENT,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () => navigationPage.navigateTo(1),
        ),
        title: Text("Criar conta"),
      ),
      body: Container(
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
                      stream: pageCreateAccountBloc.emailStream,
                    ),
                    Input(InputThemes.whiteBackground,
                      hint: "Senha",
                      margin: EdgeInsets.only(top: 20),
                      stream: pageCreateAccountBloc.passwordStream
                    ),
                    Input(InputThemes.whiteBackground,
                      hint: "Confirme a senha",
                      margin: EdgeInsets.only(top: 20),
                      stream: pageCreateAccountBloc.confirmPasswordStream,
                    ),
                    Input(InputThemes.whiteBackground,
                      hint: "Telefone",
                      margin: EdgeInsets.only(top: 20),
                      stream: pageCreateAccountBloc.phoneStream,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: MopeiButton(MopeiButtonTheme.mainTheme,
                text: "salvar",
                isLoading: pageCreateAccountBloc.isLoading,
                onTap: () => pageCreateAccountBloc.createAccount(),
              ),
            )
          ],
        ),
      ),
    );
  }

}