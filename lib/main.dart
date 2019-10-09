import 'package:flutter/material.dart';
import 'package:quizme/view/frontpage.dart';
import 'package:quizme/view/splashscreen.dart';

void main() => runApp(new MaterialApp(home: QuizMeApp()));

class QuizMeApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QuizMeAppState();
}

class _QuizMeAppState extends State<QuizMeApp> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => FrontPage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}