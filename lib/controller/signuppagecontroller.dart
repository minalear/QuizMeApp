import '../view/signuppage.dart';
//import './myfirebase.dart';
import '../view/popup.dart';
import 'package:flutter/material.dart';

class SignUpPageController {
  SignUpPageState state;

  SignUpPageController(this.state);

  String validateEmail(String value) {
    if (value == null || !value.contains('.') || !value.contains('@')) {
      return 'Enter a valid Email adress';
    }
    return null;
  }

  void saveEmail(String value) {
    state.user.email = value;
  }

  String validatePassword(String value) {
    if (value == null || value.length < 6) {
      return 'Enter a password of 6 char min';
    }
    return null;
  }

  void savePassword(String value) {
    state.user.password = value;
  }

  String validateDisplayName(String value) {
    if (value == null || value.length < 3) {
      return 'Enter at least 3 chars';
    }
    return null;
  }

  void saveDisplayName(String value) {
    state.user.username = value;
  }

  void createAccount() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }

    state.formKey.currentState.save();

    // using email/password: sign up an account at Firebase
  /*    try {
        state.user.uid = await MyFireBase.createAccount(
          email: state.user.email,
          password: state.user.password,
        );
      } catch (e) {
        PopUp.info(
          title: 'Account creation failed!',
          message: e.message != null ? e.message : e.toString(),
          context: state.context,
          action: () => Navigator.pop(state.context),
        );

        return; // do not proceed
      }

      // create user profile
      try {
        MyFireBase.createProfile(state.user);
      } catch (e) {
        state.user.displayName = null;
        state.user.zip = null;
      }

      PopUp.info(
        title: 'Account created successfully!',
        message: 'Your account is created with ${state.user.email}',
        context: state.context,
        action: () => Navigator.pop(state.context),
      ); */
  }
}
