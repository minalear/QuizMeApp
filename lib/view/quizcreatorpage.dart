import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/quiz.dart';
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
              onPressed: (){},
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
        onPressed: (){},
      ),
      body: Form(
        key: formKey,
        child: ListView.builder(
          itemCount: quiz.questions.length,
          itemBuilder: (BuildContext context, int index) {
            var question = quiz.questions[index];
            return SizedBox(
              width: double.infinity,
              height: 200,
              child: InkWell(
                onTap: (){},
                onLongPress: (){},
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
                      Image.asset('assets/notecard.png', fit: BoxFit.fill),
                      Center(
                        child: Text(question.type),
                      )
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