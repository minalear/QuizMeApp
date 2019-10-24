import 'package:flutter/material.dart';
import 'myfirebase.dart';
import '../view/signuppage.dart';
import '../view/popup.dart';
import '../model/user.dart';

class SignUpPageController {
  User user = User();
  SignUpPageState state;
  SignUpPageController(this.state);

  String validateEmail(String value) {
    // TODO: Replace this with proper email validation
    if (value == null || !value.contains('.') || !value.contains('@'))
      return 'Enter a valid Email address';
    return null;
  }
  String validateUserName(String value) {
    if (value == null || value.length < 3)
      return 'Enter at least 3 characters';
    return null;
  }
  String validatePassword(String value) {
    if (value == null || value.length < 6)
      return 'Enter a password';
    return null;
  }
  
  void saveEmail(String value) {
    user.email = value;
  }
  void saveUserName(String value) {
    user.username = value;
  }
  void savePassword(String value) {
    user.password = value;
  }

  void createAccount() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }

    state.formKey.currentState.save();

    print('${user.email} and ${user.username}');

    // Firebase Authentication/Account Creation
    try {
      user.uid = await MyFirebase.createAccount(
        email: user.email,
        password: user.password,
      );
    } catch (e) {
      PopUp.info(
        context: state.context,
        title: 'Account creation failed',
        message: e.message != null ? e.message : e.toString(),
        action: () => Navigator.pop(state.context),
      );

      return;
    }

    // Create user profile
    try {
      MyFirebase.createProfile(user);
    } catch (e) { }

    PopUp.info(
      context: state.context,
      title: 'Account created successfully!',
      message: 'Your account is created with ${user.email}',
      action: () { 
        Navigator.pop(state.context);
        Navigator.pop(state.context); 
      }
    );
  }
}