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


class PageLoginScreen extends StatefulWidget {

  PageLoginScreen({this.navigationPage});

  final CustomPageController navigationPage;

  @override
  _PageLoginScreenState createState() => _PageLoginScreenState();

}

class _PageLoginScreenState extends State<PageLoginScreen> {

  final PageLoginBloc pageLoginBloc = sharedBloc();

  final InputController emailController = InputController(
    validateBuild: (wrapper) {
      wrapper.isEmail(Strings.strings["error_invalid_email"]);
      wrapper.required(Strings.strings["error_invalid_empty_email"]);
    },
  );

  final InputController passController = InputController(
      validateBuild: (wrapper) => wrapper.required(Strings.strings["error_invalid_empty_password"])
  );

  GlobalKey<FormValidateState> formKey;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormValidateState>();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormValidate(
      key: formKey,
      padding: EdgeInsets.all(20),
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
                    hint: Strings.strings["hint_email"],
                    margin: EdgeInsets.only(top: 20),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Input(
                    InputThemes.loginTheme,
                    obscureText: true,
                    hint: Strings.strings["hint_password"],
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
              text: Strings.strings["button_login"],
              isLoading: pageLoginBloc.user.loading,
              onTap: () {
                if(formKey.currentState.validate()){
                  pageLoginBloc.doLogin(
                    email: emailController.value.text.trim(),
                    password: passController.value.text.trim()
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
                  child: Hyperlink(Strings.strings["button_forgot_password"],
                      style: TextStyles.subtitleBlack,
                      onPress: () => widget.navigationPage.navigateTo(0)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Hyperlink(
                    Strings.strings["button_sign_up"],
                    style: TextStyles.subtitleBlack,
                    onPress: () => widget.navigationPage.navigateTo(2),
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

