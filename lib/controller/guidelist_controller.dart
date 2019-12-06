import 'package:QuizMe/view/studyguidepage.dart';
import 'package:QuizMe/view/studymodepage.dart';
import 'package:flutter/material.dart';
import '../model/studyguide.dart';
import '../model/user.dart';

class GuideListController {
  void viewStudyGuide(BuildContext context, User user, StudyGuide guide) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        if (user.uid == guide.createdByUID) return StudyGuidePage(user, guide); 
                                            return StudyModePage(guide);
      }
    ));
  }
}