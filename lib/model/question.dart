enum QuestionTypes { Normal, Image, Boolean }

class Question {
  QuestionTypes type;

  // The correct answer will be set as the first possible answer
  /*String get correctAnswer { 
    return answers[0];
  }*/
}

class NormalQuestion extends Question {
  String question;
  List<String> answers;

  NormalQuestion() {
    type = QuestionTypes.Normal;
  }
}

class ImageQuestion extends Question {
  String question, imageUri;
  List<String> answers;

  ImageQuestion() {
    type = QuestionTypes.Image;
  }
}

class BooleanQuestion extends Question {
  String question;
  bool correctAnswer; // might make string?

  BooleanQuestion() {
    type = QuestionTypes.Boolean;
  }
}