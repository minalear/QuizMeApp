import 'package:QuizMe/model/user.dart';
import '../model/notecard.dart';

class StudyGuide {
  String documentId;
  String title;
  String createdBy;
  String createdByUID;
  DateTime pubDate;
  List<NoteCard> notes;

  StudyGuide({
    this.title,
    this.createdBy,
    this.createdByUID,
    this.pubDate,
    this.notes,
  });

  StudyGuide.empty() {
    this.title = '';
    this.createdBy = '';
    this.createdByUID = '';
    this.notes = <NoteCard> [];
  }
  StudyGuide.newStudyGuide(User user, String title) {
    this.title = title;
    this.createdBy = user.username;
    this.createdByUID = user.uid;
    this.notes = <NoteCard> [];
  }

  StudyGuide.clone(StudyGuide studyGuide) {
    this.documentId = studyGuide.documentId;
    this.title = studyGuide.title;
    this.createdBy = studyGuide.createdBy;
    this.createdByUID = studyGuide.createdByUID;
    this.pubDate = studyGuide.pubDate;
    this.notes = <NoteCard>[]..addAll(studyGuide.notes);
  }

  Map<String, dynamic> serialize() {
    List<String> notequestions = new List<String>();
    List<String> noteanswers = new List<String>();
    // creating the list of notecard answers and questions 
    for(int n = 0; n < notes.length; n ++ )   {
      notequestions.add(notes[n].question);
      noteanswers.add(notes[n].answer);
    }
    
    return <String, dynamic>{
      TITLE: title,
      CREATEDBY: createdBy,
      CREATEDBYUID: createdByUID,
      PUBDATE: pubDate,
      NOTEQUESTIONS: notequestions,
      NOTEANSWERS: noteanswers,
    };
  }

  static StudyGuide deserialize(Map<String, dynamic> data, String docId){
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
  }
  
  static const STUDYGUIDE_COLLECTION = 'studyguides';
  static const TITLE = 'title';
  static const CREATEDBY = 'createdby';
  static const CREATEDBYUID = 'createdByUID';
  static const PUBDATE = 'pubdate';
  // question and answer field is to serialize and deserialize the list of notecards without the use of a secondary serialization method
  static const NOTEQUESTIONS = 'notequestions';
  static const NOTEANSWERS = 'noteanswers';
}