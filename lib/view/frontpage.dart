import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:quizme/view/splashscreen.dart';

class FrontPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QuizMe'),
      ),
      body: SplashScreen(),
    );
  }
}