import 'package:flutter/material.dart';
import '../view/questioneditorpage.dart';
import '../model/question.dart';

class QuestionEditorController {
  QuestionEditorState state;
  QuestionEditorController(this.state);

  void saveQuestion(String str) {
    if (state.question.type == Question.NORMAL_TYPE) {
      var normalQuestion = NormalQuestion.clone(state.question as NormalQuestion);
      normalQuestion.question = str;
      state.question = normalQuestion;
      state.quiz.questions[state.index] = normalQuestion;
    } else if (state.question.type == Question.BOOLEAN_TYPE) {
      var booleanQuestion = BooleanQuestion.clone(state.question as BooleanQuestion);
      booleanQuestion.question = str;
      state.question = booleanQuestion;
      state.quiz.questions[state.index] = booleanQuestion;
    } else {
      var imageQuestion = ImageQuestion.clone(state.question as ImageQuestion);
      imageQuestion.question = str;
      state.question = imageQuestion;
      state.quiz.questions[state.index] = imageQuestion;
    }
  }

  void saveNormalAnswer(String str, int index, int ansIndex) {
    var normalQuestion = NormalQuestion.clone(state.question as NormalQuestion);
    normalQuestion.answers[ansIndex] = str;
    state.question = normalQuestion;
    state.quiz.questions[index] = normalQuestion;
  }
  void saveImageAnswer(String str, int index, int ansIndex) {
    var imageQuestion = ImageQuestion.clone(state.question as ImageQuestion);
    imageQuestion.answers[ansIndex] = str;
    state.question = imageQuestion;
    state.quiz.questions[index] = imageQuestion;
  }
  void saveBooleanAnswer(String answer, int index) {
    state.changeState(() 
    {
      var booleanQuestion = BooleanQuestion.clone(state.question as BooleanQuestion);
      booleanQuestion.correctAnswer = answer;
      state.question = booleanQuestion;
      state.quiz.questions[index] = booleanQuestion;
    });
  }

  void saveChanges() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }

    state.formKey.currentState.save();

    Navigator.pop(state.context);
  }
}