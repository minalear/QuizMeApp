import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/studyguide.dart';
import '../controller/studyguidepage_controller.dart';

class StudyGuidePage extends StatefulWidget {
  final User user;
  final StudyGuide studyGuide;

  StudyGuidePage(this.user, this.studyGuide);

  @override
  State<StatefulWidget> createState() {
    return StudyGuidePageState(user, studyGuide);
  }
}

class StudyGuidePageState extends State<StudyGuidePage> {
  User user;
  StudyGuide studyGuide;
  StudyGuidePageController controller;

  StudyGuidePageState(this.user, this.studyGuide) {
    controller = StudyGuidePageController(this);

    // reset display text of the notecard back to the question
    for (var noteCard in studyGuide.notes) {
      noteCard.currentDisplayText = noteCard.question;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Guide: ' + studyGuide.title),
      ),
      body: ListView.builder(
        itemCount: studyGuide.notes.length,
        itemBuilder: (BuildContext context, int index) {
          var noteCard = studyGuide.notes[index];
          return SizedBox(
            width: double.infinity,
            height: 200,
            child: InkWell(
              onTap: () => controller.onCardTap(noteCard),
              child: Card(
                color: (noteCard.currentDisplayText == noteCard.question) ? Colors.white : Colors.lightGreenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(noteCard.currentDisplayText)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}