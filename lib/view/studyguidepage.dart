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
  int noteCardEditIndex = -1;
  User user;
  StudyGuide studyGuide;
  StudyGuidePageController controller;
  var formKey = GlobalKey<FormState>();

  StudyGuidePageState(this.user, this.studyGuide) {
    controller = StudyGuidePageController(this);

    // ensure all the notecards are facing the front
    for (var noteCard in studyGuide.notes) {
      noteCard.frontFacing = true;
    }
  }

  void changeState(Function fn) {
    setState(fn);
  }

  bool editMode() {
    return noteCardEditIndex != -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(studyGuide.title),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.import_contacts),
            label: Text('Study Now'),
            onPressed: controller.goToStudyMode,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: editMode() ? Icon(Icons.delete_outline) : Icon(Icons.add),
        onPressed: editMode() ? controller.deleteNoteCard: controller.newNoteCard,
      ),
      body: Form(
        key: formKey,
        child: ListView.builder(
          itemCount: studyGuide.notes.length,
          itemBuilder: (BuildContext context, int index) {
            var noteCard = studyGuide.notes[index];
            return SizedBox(
              width: double.infinity,
              height: 200,
              child: InkWell(
                onTap: () => controller.onCardTap(noteCard),
                onLongPress: () => controller.onCardLongPress(noteCard, index),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer, // clip image to card boundaries
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(8),
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
                          child: (noteCardEditIndex == index) ? 
                            TextFormField(
                              autofocus: true,
                              initialValue: noteCard.frontFacing ? noteCard.question : noteCard.answer,
                              autocorrect: true,
                              keyboardType: TextInputType.multiline,
                              onSaved: (str) => controller.saveNoteCardText(str, index),   
                              validator: (a) { return null; },                    
                            ) : 
                            Text(
                              noteCard.frontFacing ? noteCard.question : noteCard.answer, 
                              textAlign: TextAlign.center,
                              style: TextStyle(height: 1),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}