import '../view/quizcreatorpage.dart';
import '../view/quiztakerpage.dart';
import '../model/question.dart';

class QuizCreatorController {
  QuizCreatorState state;
  QuizCreatorController(this.state);

  void onCardTap(Question question) {
    state.changeState(() {
      question.isFrontFacing = !question.isFrontFacing;
    });
  }

  void onCardLongPress(Question question) {

  }

  void saveChanges() async {

  }
}