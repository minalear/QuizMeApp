import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/quiz.dart';
import '../model/question.dart';
import '../controller/quiztaker_controller.dart';

class QuizTakerPage extends StatefulWidget {
  final User user;
  final Quiz quiz;

  QuizTakerPage(this.user, this.quiz);

  @override
  State<StatefulWidget> createState() {
    return QuizTakerState(user, quiz);
  }
}

class QuizTakerState extends State<QuizTakerPage> {
  User user;
  Quiz quiz;
  int questionIndex;
  Question currentQuestion;
  QuizTakerController controller;

  List<String> userAnswers;
  List<int> jumbledIndices;

  bool showResults = false;
  int correctAnswers = 0;
  double userScore = 0.0;

  QuizTakerState(this.user, this.quiz) {
    controller = QuizTakerController(this);
    questionIndex = 0;
    currentQuestion = quiz.questions[questionIndex];

    // initialize list of answers to blank
    userAnswers = <String>[];
    for (int i = 0; i < quiz.questions.length; i++) {
      userAnswers.add('');
    }
    controller.randomizeAnswerIndices();
  }

  void changeState(Function fn) {
    setState(fn);
  }

  Widget constructScoreBody() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "You got " + correctAnswers.toString() + "/" + quiz.questions.length.toString() + " correct!", 
              style: TextStyle(fontSize: 35, color: (userScore > 51) ? Colors.green : Colors.red)
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              userScore.toStringAsFixed(2) + '%', 
              style: TextStyle(fontSize: 45, color: (userScore > 51) ? Colors.green : Colors.red)
            )
          ],
        ),
      ],
    );
  }
  Widget constructQuestionBody(Question question) {
    switch (question.type) {
      case Question.NORMAL_TYPE: {
        var normal = question as NormalQuestion;
        return Column(
          children: <Widget>[
            Text(normal.question, style: TextStyle(fontSize: 20)),
            Divider(),
            Row(children: <Widget>[
              Text(normal.answers[controller.jumbledIndices[0]]),
              Radio(
                value: normal.answers[controller.jumbledIndices[0]],
                groupValue: userAnswers[questionIndex],
                onChanged: (v) => controller.answerQuestion(v),
              ),
            ]),
            Row(children: <Widget>[
              Text(normal.answers[controller.jumbledIndices[1]]),
              Radio(
                value: normal.answers[controller.jumbledIndices[1]],
                groupValue: userAnswers[questionIndex],
                onChanged: (v) => controller.answerQuestion(v),
              ),
            ]),
            Row(children: <Widget>[
              Text(normal.answers[controller.jumbledIndices[2]]),
              Radio(
                value: normal.answers[controller.jumbledIndices[2]],
                groupValue: userAnswers[questionIndex],
                onChanged: (v) => controller.answerQuestion(v),
              ),
            ]),
            Row(children: <Widget>[
              Text(normal.answers[controller.jumbledIndices[3]]),
              Radio(
                value: normal.answers[controller.jumbledIndices[3]],
                groupValue: userAnswers[questionIndex],
                onChanged: (v) => controller.answerQuestion(v),
              ),
            ]),
          ],
        );
      }
      break;
      case Question.BOOLEAN_TYPE: {
        var boolean = question as BooleanQuestion;
        return Column(
          children: <Widget>[
            Text(boolean.question, style: TextStyle(fontSize: 20)),
            Divider(),
            Row(children: <Widget>[
              Text("True"),
              Radio(
                value: "True",
                groupValue: userAnswers[questionIndex],
                onChanged: (v) => controller.answerQuestion(v),
              ),
            ]),
            Row(children: <Widget>[
              Text("False"),
              Radio(
                value: "False",
                groupValue: userAnswers[questionIndex],
                onChanged: (v) => controller.answerQuestion(v),
              ),
            ]),
          ],
        );
      }
      break;
    }

    throw new Exception("Invalid question type");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Next'),
        onPressed: controller.nextQuestion,
      ),
      body: Container(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Card(
            margin: EdgeInsets.all(8),
            child: Container(
              margin: EdgeInsets.all(8),
              child: showResults ? constructScoreBody() : constructQuestionBody(currentQuestion),
            ),
          ),
        ),
      ),
    );
  }
}