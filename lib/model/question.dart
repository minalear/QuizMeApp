class Question {
  String type;
  bool isFrontFacing = false; // used for visual

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
}

class ImageQuestion extends Question {
  String question, imageUri;
  List<String> answers;

  ImageQuestion({this.question, this.imageUri, this.answers}) {
    type = Question.IMAGE_TYPE;
  }
}

class BooleanQuestion extends Question {
  String question;
  bool correctAnswer; // might make string?

  BooleanQuestion({this.question, this.correctAnswer}) {
    type = Question.BOOLEAN_TYPE;
  }
}