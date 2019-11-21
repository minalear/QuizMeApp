import '../view/quizcreatorpage.dart';
import '../view/quiztakerpage.dart';
import 'package:flutter/material.dart';
import '../view/questioneditorpage.dart';
import '../model/question.dart';
import '../view/popup_input.dart';

class QuizCreatorController {
  QuizCreatorState state;
  QuizCreatorController(this.state);

  void onCardTap(Question question) {
    
  }

  void onCardLongPress(Question question, int index) async {
    var updatedQuestion = await Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => QuestionEditorPage(state.quiz, question, index),
    ));
    //state.quiz.questions[index] = updatedQuestion;
    print((updatedQuestion as NormalQuestion).question);
  }

  void addNewQuestion() async {
    // get the question type
    var questionType = await showSelectionDialog(state.context, "Question Type", ["Normal", "Image", "True/False"]);
    if (!questionType.item2) return; // user pressed cancel

    /*if (questionType.item1 == "Normal") {
      var newQuestion = NormalQuestion(question: "")
    }*/
  }

  void saveChanges() async {

  }
}