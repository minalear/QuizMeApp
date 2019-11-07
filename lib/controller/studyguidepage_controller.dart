import 'package:flutter/material.dart';
import '../model/notecard.dart';
import '../view/studyguidepage.dart';
import '../view/studymodepage.dart';

class StudyGuidePageController {
  StudyGuidePageState state;
  StudyGuidePageController(this.state);

  void onCardTap(NoteCard card) {
    // Toggle between displaying the question and the answer
    state.changeState(() {
      card.frontFacing = !card.frontFacing;
    });
  }

  void goToStudyMode() {
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => StudyModePage(state.studyGuide),
    ));
  }
}