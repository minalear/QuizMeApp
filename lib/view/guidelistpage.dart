import 'package:QuizMe/controller/guidelist_controller.dart';
import 'package:flutter/material.dart';
import '../model/studyguide.dart';
import '../model/user.dart';
import '../controller/utilities.dart';

class GuideListPage extends StatelessWidget {
  final User user;
  final List<StudyGuide> guideList;
  final GuideListController controller = GuideListController();

  GuideListPage(this.user, this.guideList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz List'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: guideList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(5),
              child: ListTile(
                leading: Image.asset('assets/notecard.png'),
                title: Text(guideList[index].title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('by ' + guideList[index].createdBy),
                    Text(dateTimeFormat(guideList[index].pubDate, 'yyyy-MM-dd')),
                  ],
                ),
                onTap: () => controller.viewStudyGuide(context, user, guideList[index]),
                onLongPress: (){},
              )
            );
          },
        )
      )
    );
  }
}