import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/quiz.dart';
import '../model/question.dart';
import '../controller/quizcreatorcontroller.dart';

class QuizCreatorPage extends StatefulWidget {
  final User user;
  final Quiz quiz;
  QuizCreatorPage(this.user, this.quiz);

  @override
  State<StatefulWidget> createState() {
    return QuizCreatorState(user, quiz);
  }
}

class QuizCreatorState extends State<QuizCreatorPage> {
  User user;
  Quiz quiz;
  QuizCreatorController controller;
  var formKey = GlobalKey<FormState>();

  bool changesMade = false; // changes made to the quiz that need to be saved
  
  QuizCreatorState(User user, Quiz quiz) {
    this.user = user;
    this.quiz = quiz;
    controller = QuizCreatorController(this);
  }

  void changeState(Function fn) {
    setState(fn);
  }

  bool editMode() {
    return false;
  }

  // construct a widget based on the question
  Widget constructQuestionCard(Question question, int index) {
    var cardText = List<InlineSpan>();
    index += 1; // index is 0 based

    if (question.type == Question.NORMAL_TYPE) {
      // question
      cardText.add(
        TextSpan(
          text: index.toString() + ') ' + (question as NormalQuestion).question + '\n\n',
          style: TextStyle(color: Colors.black)
        ),
      );

      // list of answers, highlight the correct answer in green
      int count = 0;
      (question as NormalQuestion).answers.forEach((v) {  
        cardText.add(
          TextSpan(
            text: v + '\n',
            style: TextStyle(color: (count++ == 0) ? Colors.green : Colors.black),
          ),
        );
      });
    } else if (question.type == Question.BOOLEAN_TYPE) {
      // question
      cardText.add(
        TextSpan(
          text: index.toString() + ') ' + (question as BooleanQuestion).question + '\n\n',
          style: TextStyle(color: Colors.black)
        ),
      );

      // answer
      cardText.add(
        TextSpan(
          text: (question as BooleanQuestion).correctAnswer.toString(), 
          style: TextStyle(color: Colors.green)
        ),
      );
    }

    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 4),
        child: RichText(text: TextSpan(children: cardText)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.title),
        actions: <Widget>[
          (changesMade) ? 
            FlatButton.icon(
              icon: Icon(Icons.save),
              label: Text('Save'),
              onPressed: controller.saveChanges,
            ) :
            FlatButton.icon(
              icon: Icon(Icons.import_contacts),
              label: Text('Study Now'),
              onPressed: (){},
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: editMode() ? Icon(Icons.delete_outline) : Icon(Icons.add),
        onPressed: controller.addNewQuestion,
      ),
      body: Form(
        key: formKey,
        child: ListView.builder(
          itemCount: quiz.questions.length,
          itemBuilder: (BuildContext context, int index) {
            var question = quiz.questions[index];
            return SizedBox(
              width: double.infinity,
              height: 175,
              child: InkWell(
                onTap: () => controller.onCardTap(question),
                onLongPress: () => controller.onCardLongPress(question, index),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      //Image.asset('assets/notecard.png', fit: BoxFit.fill),
                      constructQuestionCard(question, index),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ),
    );
  }
}