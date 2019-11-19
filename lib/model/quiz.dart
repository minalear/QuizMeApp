import 'package:QuizMe/model/user.dart';
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
    List<String> notequestions = new List<String>();
    List<String> noteanswers = new List<String>();
    // creating the list of notecard answers and questions 
    /*for(int n = 0; n < notes.length; n ++ )   {
      notequestions.add(notes[n].question);
      noteanswers.add(notes[n].answer);
    }*/
    
    return <String, dynamic>{
      TITLE: title,
      CREATEDBY: createdBy,
      CREATEDBYUID: createdByUID,
      PUBDATE: pubDate,
      NOTEQUESTIONS: notequestions,
      NOTEANSWERS: noteanswers,
    };
  }

  /*static StudyGuide deserialize(Map<String, dynamic> data, String docId){
    var notes = List<NoteCard>();

    var questions = data[NOTEQUESTIONS];
    var answers = data[NOTEANSWERS];

    for (int i = 0; i < questions.length; i++) {
      notes.add(NoteCard(
        question: questions[i].toString(),
        answer: answers[i].toString(),
      ));
    }
    
    var studyGuide = StudyGuide(
      title: data[TITLE],
      createdBy: data[CREATEDBY],
      createdByUID: data[CREATEDBYUID],
      //pubDate: DateTime.fromMillisecondsSinceEpoch(data[PUBDATE]),
      pubDate: DateTime.now(),
      notes: notes,
    );
    studyGuide.documentId = docId;

    return studyGuide;
  }*/
  
  static const QUIZ_COLLECTION = 'quizzes';
  static const TITLE = 'title';
  static const CREATEDBY = 'createdby';
  static const CREATEDBYUID = 'createdByUID';
  static const PUBDATE = 'pubdate';
  // question and answer field is to serialize and deserialize the list of notecards without the use of a secondary serialization method
  static const NOTEQUESTIONS = 'notequestions';
  static const NOTEANSWERS = 'noteanswers';
}