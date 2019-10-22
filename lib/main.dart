import 'package:flutter/material.dart';
import './view/loginpage.dart';
import './view/splashscreen.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    backgroundColor: Colors.blue,
  ),
  home: QuizMeApp())
);

class QuizMeApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QuizMeAppState();
}

class _QuizMeAppState extends State<QuizMeApp> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration(seconds: 1), () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => LoginPage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}