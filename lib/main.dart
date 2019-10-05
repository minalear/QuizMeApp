import 'package:flutter/material.dart';
import 'package:quizme/view/frontpage.dart';

void main() => runApp(QuizMeApp());

class QuizMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FrontPage(),
    );
  }
}