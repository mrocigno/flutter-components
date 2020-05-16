import 'package:infrastructure/flutter/components/inputs/FormValidate.dart';
import 'package:infrastructure/flutter/components/inputs/InputController.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/inputs/InputText.dart';
import 'package:infrastructure/flutter/components/buttons/MopeiButton.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:mopei_app/src/ui/login/LoginModal.dart';
import 'package:mopei_app/src/ui/login/pageforgotpassword/PageForgotPasswordBloc.dart';

class PageForgotPasswordScreen extends StatefulWidget {
  PageForgotPasswordScreen({this.navigationPage});

  final CustomPageController navigationPage;

  @override
  _PageForgotPasswordScreenState createState() => _PageForgotPasswordScreenState();

}

class _PageForgotPasswordScreenState extends State<PageForgotPasswordScreen> {

  final pageForgotPasswordBloc = PageForgotPasswordBloc();

  final InputController emailController = InputController(
    validateBuild: (wrapper) {
      wrapper.isEmail(Strings.strings["error_invalid_email"]);
      wrapper.required(Strings.strings["error_invalid_empty_email"]);
    },
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
  }

  @override
  Widget build(BuildContext context) {

    return FormValidate(
      key: formKey,
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(Strings.strings["forgot_password"],
              style: TextStyle(
                  color: Colors.black
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Input(InputThemes.loginTheme,
                    hint: Strings.strings["hint_email"],
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
            child: MopeiButton(
              text: Strings.strings["button_send"],
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