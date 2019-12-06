import 'package:QuizMe/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/question.dart';

class Quiz {
  String documentId;
  String title;
  String createdBy;
  String createdByUID;
  DateTime pubDate;
  List<Question> questions;

  Quiz({
    this.title,
    this.createdBy,
    this.createdByUID,
    this.pubDate,
    this.questions,
  });

  Quiz.empty() {
    this.title = '';
    this.createdBy = '';
    this.createdByUID = '';
    this.questions = <Question> [];
  }
  Quiz.newQuiz(User user, String title) {
    this.title = title;
    this.createdBy = user.username;
    this.createdByUID = user.uid;
    this.questions = <Question> [];
  }

  Quiz.clone(Quiz quiz) {
    this.documentId = quiz.documentId;
    this.title = quiz.title;
    this.createdBy = quiz.createdBy;
    this.createdByUID = quiz.createdByUID;
    this.pubDate = quiz.pubDate;
    this.questions = <Question>[]..addAll(quiz.questions);
  }

  Map<String, dynamic> serialize() {
    // serializes the questions as an array of maps, 
    // with each map containing necessary information based on the question type
    var questionsArray = List<Map<String, dynamic>>();
    for (int i = 0; i < questions.length; i++) {
      var map = Map<String, dynamic>();
      map[Question.TYPE] = questions[i].type;
      
      switch (questions[i].type) {
        case Question.NORMAL_TYPE: 
          var question = questions[i] as NormalQuestion;
          map[Question.QUESTION] = question.question;
          map[Question.ANSWERS] = question.answers;

          break;
        case Question.IMAGE_TYPE: 
          var question = questions[i] as ImageQuestion;
          map[Question.IMAGEURI] = question.imageUri;
          map[Question.QUESTION] = question.question;
          map[Question.ANSWERS] = question.answers;

          break;
        case Question.BOOLEAN_TYPE: 
          var question = questions[i] as BooleanQuestion;
          map[Question.QUESTION] = question.question;
          map[Question.ANSWER] = question.correctAnswer;

          break;
      }

      questionsArray.add(map);
    }
    
    // map of our entire quiz
    return <String, dynamic>{
      TITLE: title,
      CREATEDBY: createdBy,
      CREATEDBYUID: createdByUID,
      PUBDATE: pubDate,
      QUESTIONS: questionsArray,
    };
  }

  static Quiz deserialize(Map<String, dynamic> data, String docId){
    var questions = List<Question>();
    for (var question in data[QUESTIONS]) {
      switch (question[Question.TYPE]) {
        case Question.NORMAL_TYPE: 
          // normal question type
          var answerList = List<String>();
          for (var answer in question[Question.ANSWERS]) {
            answerList.add(answer);
          }

          questions.add(NormalQuestion(
            question: question[Question.QUESTION],
            answers: answerList,
          ));
          break;
        case Question.IMAGEURI:
          // image question type
          var answerList = List<String>();
          for (var answer in question[Question.ANSWERS]) {
            answerList.add(answer);
          }

          questions.add(ImageQuestion(
            question: question[Question.QUESTION],
            imageUri: question[Question.IMAGEURI],
            answers: answerList,
          ));
          break;
        case Question.BOOLEAN_TYPE:
          // boolean question type
          questions.add(BooleanQuestion(
            question: question[Question.QUESTION],
            correctAnswer: question[Question.ANSWER],
          ));
          break;
      }
    }

    var quiz = Quiz(
      title: data[TITLE],
      createdBy: data[CREATEDBY],
      createdByUID: data[CREATEDBYUID],
      pubDate: DateTime.fromMicrosecondsSinceEpoch((data[PUBDATE] as Timestamp).microsecondsSinceEpoch),
      questions: questions,
    );
    quiz.documentId = docId;
    return quiz;
  }
  
  static const QUIZ_COLLECTION = 'quizzes';
  static const TITLE = 'title';
  static const CREATEDBY = 'createdBy';
  static const CREATEDBYUID = 'createdByUID';
  static const PUBDATE = 'pubdate';
  static const QUESTIONS = 'questions';
}