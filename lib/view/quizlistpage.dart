import 'package:QuizMe/controller/quizlist_controller.dart';
import 'package:flutter/material.dart';
import '../model/quiz.dart';
import '../model/user.dart';
import '../controller/utilities.dart';

class QuizListPage extends StatelessWidget {
  final User user;
  final List<Quiz> quizList;
  final QuizListController controller = QuizListController();

  QuizListPage(this.user, this.quizList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz List'),
      ),
      body: Center(
        child: (quizList == null || quizList.length == 0) ? Container(child: Text('No quizzes found!')) :
        ListView.builder(
          itemCount: quizList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(5),
              child: ListTile(
                leading: Image.asset('assets/quiz_icon.png'),
                title: Text(quizList[index].title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('by ' + quizList[index].createdBy),
                    Text(dateTimeFormat(quizList[index].pubDate, 'yyyy-MM-dd')),
                  ],
                ),
                onTap: () => controller.viewQuiz(context, user, quizList[index]),
                onLongPress: (){},
              )
            );
          },
        )
      )
    );
  }
}