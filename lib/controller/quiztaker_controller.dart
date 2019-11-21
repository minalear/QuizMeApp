import 'dart:math';
import '../view/quiztakerpage.dart';
import '../model/question.dart';

class QuizTakerController {
  QuizTakerState state;
  QuizTakerController(this.state);

  List<int> jumbledIndices;

  void randomizeAnswerIndices() {
    var rng = Random(DateTime.now().millisecondsSinceEpoch);

    var numbers = [0, 1, 2, 3];
    for (int i = 0; i < 20; i++) {
      var a = rng.nextInt(numbers.length);
      var b = rng.nextInt(numbers.length);
      var temp = numbers[a];
      numbers[a] = numbers[b];
      numbers[b] = temp;
    }

    jumbledIndices = numbers;
  }

  void nextQuestion() {
    if (state.questionIndex < state.quiz.questions.length - 1) {
      state.changeState(() {
        state.questionIndex++;
        state.currentQuestion = state.quiz.questions[state.questionIndex];
      });
      randomizeAnswerIndices();
    } else {
      state.changeState(() {
        calculateResults();
        state.showResults = true;
      });
    }
  }

  void answerQuestion(String answer) {
    state.changeState(() {
      state.userAnswers[state.questionIndex] = answer;
    });
  }

  void calculateResults() {
    state.correctAnswers = 0;
    state.userScore = 0.0;

    // total up the number of correct answers the user has made
    for (int i = 0; i < state.quiz.questions.length; i++) {
      if (state.quiz.questions[i].type == Question.NORMAL_TYPE) {
        // the first answer in the array is the correct answer
        if (state.userAnswers[i] == (state.quiz.questions[i] as NormalQuestion).answers[0]) {
          state.correctAnswers += 1;
        }
      } else if (state.quiz.questions[i].type == Question.IMAGE_TYPE) {
        // the first answer in the array is the correct answer
        if (state.userAnswers[i] == (state.quiz.questions[i] as ImageQuestion).answers[0]) {
          state.correctAnswers += 1;
        }
      } 
      else if (state.quiz.questions[i].type == Question.BOOLEAN_TYPE) {
        if (state.userAnswers[i] == (state.quiz.questions[i] as BooleanQuestion).correctAnswer) {
          state.correctAnswers += 1;
        }
      }
    }

    state.userScore = (state.correctAnswers.toDouble() / state.quiz.questions.length) * 100;
  }
}