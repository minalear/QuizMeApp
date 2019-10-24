import 'package:QuizMe/view/studyguidepage.dart';
import 'package:flutter/material.dart';
import 'myfirebase.dart';
import '../view/homepage.dart';
import '../view/loginpage.dart';
import '../model/studyguide.dart';

class HomePageController {
  HomePageState state;
  HomePageController(this.state);

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