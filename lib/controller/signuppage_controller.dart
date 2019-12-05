import 'package:flutter/material.dart';
import 'myfirebase.dart';
import '../view/signuppage.dart';
import '../view/popup.dart';
import '../model/user.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPageController {
  User user = User();
  SignUpPageState state;
  SignUpPageController(this.state);
  
  void uploadProfileImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    state.setState(() {
      state.profileImage = image;
      state.profileImageSet = true;
    });
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

    // Upload profile image
    try {
      if (state.profileImageSet) {
        MyFirebase.uploadProfileImage(state.profileImage, user.uid);
        user.profileImageUri = await MyFirebase.getProfileImage(user.uid);
      }
    } catch(e) {}

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