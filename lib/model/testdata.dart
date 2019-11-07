import 'studyguide.dart';
import 'notecard.dart';

class TestData {
  // Test data that will be replaced in Sprint 2
  static List<StudyGuide> testStudyGuides = [
    StudyGuide(
      title: "Biology 101",
      createdBy: "drogeth",
      pubDate: DateTime.now(),
      notes: [
        NoteCard(question: "Define Mitochondria", answer: "The powerhouse of the cell."),
        NoteCard(question: "What does DNA stand for?", answer: "Deoxyribonucleic Acid"),
        NoteCard(question: "Who is the best Biology Professor?", answer: "Jim Bidlack"),
      ]
    ),
    StudyGuide(
      title: "Beginning Programming",
      createdBy: "troe1",
      pubDate: DateTime.now(),
      notes: [
        NoteCard(question: "What is the difference between a class and an object?", answer: "An object is an instance of a class."),
        NoteCard(question: "How many bits are in a byte?", answer: "8"),
      ]
    ),
    StudyGuide(
      title: "History",
      createdBy: "dolson420",
      pubDate: DateTime.now(),
      notes: [
        NoteCard(question: "What year did the United States earn its independence?  This is a pretty easy question bro, imma throw another one at ya.  What color is the sky on the last Wednesday of 1596?  That is also a pretty easy question my man, so how about this thinker?", answer: "1776 and Blue"),
        NoteCard(question: "What year did the American Civil War start?", answer: "1861"),
        NoteCard(question: "Who was the 27th president?", answer: "William Howard Taft"),
        NoteCard(question: "How long did the Hundred Years' war last?", answer: "116 years"),        
      ]
    ),
  ];
}