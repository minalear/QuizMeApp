import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class FrontPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QuizMe'),
      ),
      body: TeXView(
        teXHTML: r"$$\frac{dy}{dt} = t^2 - y^3$$",
      ),
    );
  }
}