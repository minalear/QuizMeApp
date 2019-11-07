import 'package:flutter/material.dart';
import '../model/notecard.dart';
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
    if (state.studyGuide.notes[id].frontFacing) {
      state.studyGuide.notes[id].question = str;
    } else {
      state.studyGuide.notes[id].answer = str;
    }
  }

  void goToStudyMode() {
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => StudyModePage(state.studyGuide),
    ));
  }
}