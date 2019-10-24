import 'package:flutter/material.dart';
import 'myfirebase.dart';
import '../view/homepage.dart';
import '../view/loginpage.dart';
import '../view/profilepage.dart';
import '../view/studyguidepage.dart';
import '../model/studyguide.dart';

class HomePageController {
  HomePageState state;
  HomePageController(this.state);

  void myProfile() {
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => ProfilePage(state.user),
    ));
  }

  void signOut() {
    MyFirebase.signOut();
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => LoginPage(),
    ));
  }

  void viewStudyGuide(StudyGuide guide) {
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => StudyGuidePage(state.user, guide),
    ));
  }
}