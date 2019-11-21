import 'package:flutter/material.dart';
import '../model/question.dart';
import '../model/quiz.dart';
import '../controller/questioneditorcontroller.dart';

class QuestionEditorPage extends StatefulWidget {
  final Quiz quiz;
  final Question question;
  final int index;

  QuestionEditorPage(this.quiz, this.question, this.index);

  @override
  State<StatefulWidget> createState() {
    return QuestionEditorState(quiz, question, index);
  }
}

class QuestionEditorState extends State<QuestionEditorPage> {
  Quiz quiz;
  Question question;
  int index;

  QuestionEditorController controller;
  var formKey = GlobalKey<FormState>();
  
  QuestionEditorState(Quiz quiz, Question question, int index) {
    this.quiz = quiz;
    this.question = question;
    this.index = index;
    
    controller = QuestionEditorController(this);
  }

  void changeState(Function fn) {
    setState(fn);
  }

  Widget constructFormBody(Question question) {
    switch (question.type) {
      case Question.NORMAL_TYPE: {
        var normal = question as NormalQuestion;
        var formFields = List<TextFormField>();

        var questionField = TextFormField(
          autocorrect: true,
          initialValue: normal.question,
          keyboardType: TextInputType.multiline,
          onSaved: controller.saveQuestion,
          validator: (a) { return null; } // @TODO: Perform proper form validation
        );

        for (int i = 0; i < 4; i++) {
          formFields.add(TextFormField(
            autocorrect: true,
            initialValue: normal.answers[i],
            keyboardType: TextInputType.multiline,
            onSaved: (v) {},
            validator: (a) { return null; } // @TODO: Perform proper form validation
          ));
        }

        return Container(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Card(
              margin: EdgeInsets.all(8),
              child: Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    questionField, // question
                    Divider(),
                    formFields[0],
                    formFields[1],
                    formFields[2],
                    formFields[3],
                  ],
                ),
              ),
            ),
          ),
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
        title: Text('Question Editor'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.save),
            label: Text('Save'),
            onPressed: controller.saveChanges,
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: constructFormBody(question),
      ),
    );
  }
}