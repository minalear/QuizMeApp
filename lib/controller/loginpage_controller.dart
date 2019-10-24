import 'package:flutter/material.dart';
import 'myfirebase.dart';
import '../view/loginpage.dart';
import '../view/signuppage.dart';
import '../view/homepage.dart';
import '../view/popup.dart';
import '../model/user.dart';

class LoginPageController {
  User user = User();
  LoginPageState state;
  LoginPageController(this.state);

  void saveEmail(String value) {
    user.email = value;
  }
  void savePassword(String value) {
    user.password = value;
  }

  void login() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }

    state.formKey.currentState.save();

    PopUp.showProgressBar(state.context);

    try {
      user.uid = await MyFirebase.login(
        email: user.email, 
        password: user.password,
      );
    } catch (e) {
      PopUp.popProgressBar(state.context);
      PopUp.info(
        context: state.context,
        title: 'Login Error',
        message: e.message != null ? e.message : e.toString(),
        action: () => Navigator.pop(state.context),
      );
      return;
    }

    // Login success => Read user profile
    try {
      user = await MyFirebase.readProfile(user.uid);
    } catch (e) {
      PopUp.info(
        context: state.context,
        title: 'Login Unsuccessful',
        message: e.message != null ? e.message : e.toString(),
        action: () {
          Navigator.pop(state.context);
          return;
        },
      );
    }

    PopUp.popProgressBar(state.context);
    Navigator.pop(state.context);
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => HomePage(user),
    ));
  }

  // Called from the create account button on the Login Page
  void createAccount() {
    Navigator.push(
      state.context,
      MaterialPageRoute(
      builder: (context) => SignUpPage(),
    ));
  }
}