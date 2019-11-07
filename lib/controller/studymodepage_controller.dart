import 'package:flutter/material.dart';
import '../view/studymodepage.dart';
import '../model/notecard.dart';

class StudyModePageController {
  StudyModePageState state;
  StudyModePageController(this.state);

  int activeCardIndex = 0;

  void init() {
    state.activeCard = state.studyGuide.notes[activeCardIndex];
  }

  void onVerticalSwipe(DragEndDetails arg) {
    // print(arg.primaryVelocity);
    // on negative velocity, the user is swipping up, while postivie velocity the user is swipping down
    flipCard();
  }
  void onHorizontalSwipe(DragEndDetails arg) {
     print(arg.primaryVelocity);
    // on negative velocity, the user is swipping left, while postivie velocity the user is swipping right
    if (arg.primaryVelocity < 0) nextCard();
    else previousCard();
  }

  void flipCard() {
    state.changeState(() {
      state.activeCard.frontFacing = !state.activeCard.frontFacing;
    });
  }

  void previousCard() {
    state.changeState(() {
      // ensure we don't deccrement past our available notes
      activeCardIndex = (activeCardIndex - 1 < 0) ? activeCardIndex : activeCardIndex - 1;
      state.activeCard = state.studyGuide.notes[activeCardIndex];
    });
  }

  void nextCard() {
    state.changeState(() {
      // ensure we don't increment past our available notes
      activeCardIndex = (activeCardIndex + 1 == state.studyGuide.notes.length) ? activeCardIndex : activeCardIndex + 1;
      state.activeCard = state.studyGuide.notes[activeCardIndex];
    });
  }
}