class Question {
  String question;
  List<String> answers;

  // The correct answer will be set as the first possible answer
  String get correctAnswer { 
    return answers[0];
  }
}