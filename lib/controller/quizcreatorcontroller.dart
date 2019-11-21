import 'package:flutter/material.dart';
import '../view/quizcreatorpage.dart';
import '../view/quiztakerpage.dart';
import '../controller/myfirebase.dart';
import '../view/questioneditorpage.dart';
import '../model/question.dart';
import '../view/popup_input.dart';

class QuizCreatorController {
  QuizCreatorState state;
  QuizCreatorController(this.state);

  void takeQuiz() {
    if (state.quiz.questions.length <= 0) return;
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => QuizTakerPage(state.user, state.quiz),
    ));
  }

  void onCardTap(Question question) {
    
  }

  void onCardLongPress(Question question, int index) async {
    await Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => QuestionEditorPage(state.quiz, question, index),
    ));
    state.changeState(() {
      state.changesMade = true;
    });
  }

  void addNewQuestion() async {
    // get the question type
    var questionType = await showSelectionDialog(state.context, "Question Type", ["Normal", "Image", "True/False"]);
    if (!questionType.item2) return; // user pressed cancel

    if (questionType.item1 == "Normal") {
      var newQuestion = NormalQuestion(
        question: '', 
        answers: ['','','',''],
      );
      state.quiz.questions.add(newQuestion);
    } else if (questionType.item1 == "True/False") {
      var newQuestion = BooleanQuestion(
        question: '',
        correctAnswer: "True",
      );
      state.quiz.questions.add(newQuestion);
    }

    var index = state.quiz.questions.length - 1;
    var question = state.quiz.questions[index];
    await Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => QuestionEditorPage(state.quiz, question, index),
    ));
    state.changeState(() {
      state.changesMade = true;
    });
  }

  void saveChanges() async {
    state.changeState(() {
      state.changesMade = false;
    });

    state.quiz.pubDate = DateTime.now();
    if (state.quiz.documentId == null || state.quiz.documentId == '') {
      // save as new
      var value = await MyFirebase.addQuiz(state.quiz);
      state.quiz.documentId = value;
      state.quiz.createdByUID = state.user.uid;
    } else {
      // update quiz
      await MyFirebase.updateQuiz(state.quiz);
    }

    state.user.quizzes = await MyFirebase.getUserQuizzes(state.user.uid);
  }
}