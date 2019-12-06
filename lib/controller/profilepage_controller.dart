import 'package:QuizMe/controller/myfirebase.dart';
import 'package:flutter/material.dart';
import '../view/quizlistpage.dart';
import '../view/guidelistpage.dart';
import '../view/profilepage.dart';

class ProfilePageController {
  ProfilePageState state;
  ProfilePageController(this.state);

  void seeRecentQuizzes() async {
    var quizList = await MyFirebase.getUserQuizzes(state.user.uid);
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => QuizListPage(state.user, quizList),
    ));
  }
  void seeRecentStudyGuides() async {
    var guideList = await MyFirebase.getUserStudyGuides(state.user.uid);
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => GuideListPage(state.user, guideList),
    ));
  }
}