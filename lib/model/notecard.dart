class NoteCard {
  
  String question;
  String answer;
  String currentDisplayText;

  NoteCard({this.question, this.answer}) {
    currentDisplayText = question;
  }

  // create an empty notecard
  NoteCard.empty() {
    answer = '';
    question = '';
    currentDisplayText = '';
  }

  // check to see if the notecard is empty for saving purposes
  bool isEmpty() {
    return (answer == '' && question == '');
  }

  // check that the notecard is completed to ensure no incomplete notecard is saved
  bool completed() {
    return !(answer == '' || question == '');
  }
}