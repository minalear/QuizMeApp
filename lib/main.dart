import 'package:flutter/material.dart';
import './view/loginpage.dart';
import './view/splashscreen.dart';
import 'controller/utilities.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    accentColor: hexToColor("#FBEAFF"),
    accentColorBrightness: Brightness.light,
    backgroundColor: hexToColor("#845EC2"),
    buttonColor: hexToColor("#B39CD0"),
    hintColor: hexToColor("#00C9A7"),
    primaryColor: hexToColor("#B39CD0"),
    primaryColorBrightness: Brightness.light,
    primaryColorDark: hexToColor("#4B4453"),
    scaffoldBackgroundColor: hexToColor("#845EC2"),
    splashColor: hexToColor("#00C9A7"),
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