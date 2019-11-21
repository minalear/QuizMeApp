class Question {
  String type = "";

  // serialization values
  static const NORMAL_TYPE = "normal";
  static const IMAGE_TYPE = "image";
  static const BOOLEAN_TYPE = "boolean";

  static const TYPE = "type";
  static const QUESTION = "question";
  static const ANSWER = "answer";
  static const ANSWERS = "answers";
  static const IMAGEURI = "imageUri";
}

class NormalQuestion extends Question {
  String question;
  List<String> answers;

  NormalQuestion({this.question, this.answers}) {
    type = Question.NORMAL_TYPE;
  }

  NormalQuestion.clone(NormalQuestion question) {
    this.question = question.question;
    this.answers = <String>[]..addAll(question.answers);
    this.type = Question.NORMAL_TYPE;
  }
}

class ImageQuestion extends Question {
  String question, imageUri;
  List<String> answers;

  ImageQuestion({this.question, this.imageUri, this.answers}) {
    type = Question.IMAGE_TYPE;
  }

  ImageQuestion.clone(ImageQuestion question) {
    this.question = question.question;
    this.imageUri = question.imageUri;
    this.answers = <String>[]..addAll(question.answers);
    this.type = Question.IMAGE_TYPE;
  }
}

class BooleanQuestion extends Question {
  String question;
  String correctAnswer;

  BooleanQuestion({this.question, this.correctAnswer}) {
    type = Question.BOOLEAN_TYPE;
  }

  BooleanQuestion.clone(BooleanQuestion question) {
    this.question = question.question;
    this.correctAnswer = question.correctAnswer;
    this.type = Question.BOOLEAN_TYPE;
  }
}