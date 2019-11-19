import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/quiz.dart';
import '../controller/quizcreatorcontroller.dart';

class QuizCreatorPage extends StatefulWidget {
  final User user;
  final Quiz quiz;
  QuizCreatorPage(this.user, this.quiz);

  @override
  State<StatefulWidget> createState() {
    return QuizCreatorState(user, quiz);
  }
}

class QuizCreatorState extends State<QuizCreatorPage> {
  User user;
  Quiz quiz;
  QuizCreatorController controller;
  
  QuizCreatorState(User user, Quiz quiz) {
    this.user = user;
    this.quiz = quiz;
    controller = QuizCreatorController(this);
  }

  void changeState(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}