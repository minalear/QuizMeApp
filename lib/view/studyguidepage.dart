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

    // ensure all the notecards are facing the front
    for (var noteCard in studyGuide.notes) {
      noteCard.frontFacing = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Guide: ' + studyGuide.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){},
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
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(
                      noteCard.frontFacing ? 'assets/notecard.png' : 'assets/notecard-back.png',
                      fit: BoxFit.fill,
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 4),
                        child: Text(
                          noteCard.frontFacing ? noteCard.question : noteCard.answer, 
                          textAlign: TextAlign.center,
                          style: TextStyle(height: 1),
                        ),
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 5,
                margin: EdgeInsets.all(8),
              ),
            ),
          );
        },
      ),
    );
  }
}