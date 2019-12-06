import 'package:QuizMe/view/quizcreatorpage.dart';
import 'package:QuizMe/view/quiztakerpage.dart';
import 'package:flutter/material.dart';
import '../model/quiz.dart';
import '../model/user.dart';

class QuizListController {
  void viewQuiz(BuildContext context, User user, Quiz quiz) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        if (user.uid == quiz.createdByUID) return QuizCreatorPage(user, quiz); 
                                           return QuizTakerPage(user, quiz);
      }
    ));
  }
}