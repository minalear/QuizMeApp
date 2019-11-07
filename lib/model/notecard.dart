class NoteCard {
  
  String question;
  String answer;
  bool frontFacing;

  NoteCard({this.question, this.answer}) {
    frontFacing = true;
  }

  // create an empty notecard
  NoteCard.empty() {
    answer = '';
    question = '';
    frontFacing = true;
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