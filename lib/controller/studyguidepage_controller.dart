import '../model/notecard.dart';
import '../view/studyguidepage.dart';

class StudyGuidePageController {
  StudyGuidePageState state;
  StudyGuidePageController(this.state);

  void onCardTap(NoteCard card) {
    // Toggle between displaying the question and the answer
    state.setState(() {
      card.frontFacing = !card.frontFacing;
    });
  }
}