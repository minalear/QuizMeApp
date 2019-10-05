import 'package:flutter/material.dart';
import 'package:quizme/view/frontpage.dart';
import 'package:quizme/view/splashscreen.dart';

void main() => runApp(QuizMeApp());

class QuizMeApp extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class _QuizMeAppState extends State<QuizMeApp> {
  @override
  Widget build(BuildContext context) {
    
  }
}