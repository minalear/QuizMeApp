import 'package:QuizMe/controller/myfirebase.dart';
import 'package:flutter/material.dart';
import '../model/notecard.dart';
import '../model/studyguide.dart';
import '../view/studyguidepage.dart';
import '../view/studymodepage.dart';

class StudyGuidePageController {
  StudyGuidePageState state;
  StudyGuidePageController(this.state);

  void onCardTap(NoteCard card) {
    state.changeState(() {
      // Check if we're currently editing a notecard, if so save the text and leave edit mode
      if (state.noteCardEditIndex != -1) {
        if (!state.formKey.currentState.validate()) return;
        state.formKey.currentState.save();

        state.noteCardEditIndex = -1;
      }
      else {
        // Toggle between displaying the question and the answer
        card.frontFacing = !card.frontFacing;
      }
    });
  }

  void onCardLongPress(NoteCard card, int id) {
    state.changeState(() {
      if (!state.formKey.currentState.validate()) return; // save current text changes (if we're editing)
      state.noteCardEditIndex = (state.noteCardEditIndex == -1) ? id : -1;
    });
  }

  void saveNoteCardText(String str, int id) {
    state.changesMade = true;
    if (state.studyGuide.notes[id].frontFacing) {
      state.studyGuide.notes[id].question = str;
    } else {
      state.studyGuide.notes[id].answer = str;
    }
  }

  void newNoteCard() {
    state.changeState(() {
      state.changesMade = true;
      state.studyGuide.notes.add(NoteCard(
        question: '[Question]',
        answer: '[Answer]',
      ));
    });
  }

  void deleteNoteCard() {
    state.changeState(() {
      state.changesMade = true;
      state.studyGuide.notes.removeAt(state.noteCardEditIndex);
      state.noteCardEditIndex = -1;
    });
  }

  void goToStudyMode() {
    if (state.studyGuide.notes.length <= 0) return;
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => StudyModePage(state.studyGuide),
    ));
  }

  // When the user presses the save changes button, set changesMade to false
  void saveChanges() async {
    state.changeState(() {
      state.changesMade = false;
    });

    state.studyGuide.pubDate = DateTime.now();
    if (state.studyGuide.documentId == null || state.studyGuide.documentId == '') {
      // save as new
      var value = await MyFirebase.addStudyGuide(state.studyGuide);
      state.studyGuide.createdByUID = value;
    } else {
      // update study guide
      await MyFirebase.updateStudyGuide(state.studyGuide);
    }

    state.user.studyGuides = await MyFirebase.getStudyGuides(state.user.uid);
  }
}