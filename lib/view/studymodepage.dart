import 'package:QuizMe/model/notecard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/studyguide.dart';
import '../controller/studymodepage_controller.dart';

class StudyModePage extends StatefulWidget {
  final StudyGuide studyGuide;

  StudyModePage(this.studyGuide);

  @override
  State<StatefulWidget> createState() {
    return StudyModePageState(studyGuide);
  }
}

class StudyModePageState extends State<StudyModePage> {
  NoteCard activeCard;
  StudyGuide studyGuide;
  StudyModePageController controller;

  StudyModePageState(this.studyGuide) {
    controller = StudyModePageController(this);

    // ensure all the notecards are facing the front
    for (var noteCard in studyGuide.notes) {
      noteCard.frontFacing = true;
    }
  }

  void changeState(Function fn) {
    setState(fn);
  }

  @override
  void initState() {
    super.initState();

    controller.init();
    // force the user into landscape mode, only for study mode
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() {
    // reset the orientation options to allow portrait/landscape mode in the rest of the app
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: controller.flipCard,
        onVerticalDragEnd: controller.onVerticalSwipe,
        onHorizontalDragEnd: controller.onHorizontalSwipe,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer, // clip image to card boundaries
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 5,
            margin: EdgeInsets.all(16),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  activeCard.frontFacing ? 'assets/notecard.png' : 'assets/notecard-back.png',
                  fit: BoxFit.fill,
                ),
                Center(
                  child: Container(
                    child: Text(
                      activeCard.frontFacing ? activeCard.question : activeCard.answer,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}