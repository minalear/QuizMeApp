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
      state.question = BooleanQuestion.clone(state.question as BooleanQuestion);
    } else {
      state.question = ImageQuestion.clone(state.question as ImageQuestion);
    }
  }

  void saveChanges() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }

    state.formKey.currentState.save();

    Navigator.pop(state.context);
  }
}