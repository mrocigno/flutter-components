
import 'package:infrastructure/flutter/base/BaseBloc.dart';

class PageForgotPasswordBloc extends BaseBloc {

  changePassword() {
    launchData(() async {
      await Future.delayed(Duration(seconds: 2));
    });
  }
}