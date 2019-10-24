import '../model/notecard.dart';

class StudyGuide {
  String documentId;
  String title;
  String createdBy;
  DateTime pubDate;
  List<NoteCard> notes;

  StudyGuide({
    this.title,
    this.createdBy,
    this.pubDate,
    this.notes,
  });

  StudyGuide.empty() {
    this.title = '';
    this.createdBy = '';
    this.notes = <NoteCard> [];
  }

  StudyGuide.clone(StudyGuide studyGuide) {
    this.documentId = studyGuide.documentId;
    this.title = studyGuide.title;
    this.createdBy = studyGuide.createdBy;
    this.pubDate = studyGuide.pubDate;
    this.notes = <NoteCard>[]..addAll(studyGuide.notes);
  }

  Map<String, dynamic> serialize() {
    List<String> notequestions;
    List<String> noteanswers;
    // creating the list of notecard answers and questions 
    for(int n = 0; n < notes.length; n ++ )   {
      notequestions.add(notes[n].question);
      noteanswers.add(notes[n].answer);
    }
    
    return <String, dynamic>{
      TITLE: title,
      CREATEDBY: createdBy,
      PUBDATE: pubDate,
      NOTEQUESTIONS: notequestions,
      NOTEANSWERS: noteanswers,
    };
  }

  static StudyGuide deserialize(Map<String, dynamic> data, String docId){
    List<NoteCard> notes;

    List<String> questions = data[NOTEQUESTIONS];
    List<String> answers = data[NOTEANSWERS];

    for (int i = 0; i < questions.length; i++) {
      notes.add(NoteCard(
        question: questions[i],
        answer: answers[i],
      ));
    }
    
    var studyGuide = StudyGuide(
      title: data[TITLE],
      createdBy: data[CREATEDBY],
      pubDate: data[PUBDATE],
      notes: notes,
    );
    studyGuide.documentId = docId;

    return studyGuide;
  }

  
  
  static const STUDYGUIDECOLLECTION = 'studyguides';
  static const TITLE = 'title';
  static const CREATEDBY = 'createdby';
  static const PUBDATE = 'pubdate';
  // question and answer field is to serialize and deserialize the list of notecards without the use of a secondary serialization method
  static const NOTEQUESTIONS = 'notequestions';
  static const NOTEANSWERS = 'noteanswers';
}