import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'myfirebase.dart';
import '../view/homepage.dart';
import '../view/loginpage.dart';
import '../view/profilepage.dart';
import '../view/studyguidepage.dart';
import '../model/studyguide.dart';
import '../view/popup_input.dart';
import '../controller/validator.dart';

class HomePageController {
  HomePageState state;
  HomePageController(this.state);

  void myProfile() {
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => ProfilePage(state.user),
    ));
  }

  void signOut() {
    MyFirebase.signOut();
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => LoginPage(),
    ));
  }

  void viewStudyGuide(StudyGuide guide) {
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => StudyGuidePage(state.user, guide),
    ));
  }

  void createNewStudyGuide() async {
    var popupTitle = 'Enter Title';
    var popupHintText = '[Biology 101, Mobile App Development, etc.]';
    var userInput = '';

    // loop through until the user enters valid input or hit cancel
    while (true) {
      var result = await showInputDialog(state.context, popupTitle, popupHintText);
      userInput = result.item1;

      if (result.item2) {
        // user pressed okay, check for valid input
        if (Validator.validateTitle(result.item1) == null) break; // go to study guide page
        else {
          // set title and hint text to indicate to user that they need to create valid input
          popupTitle = 'Enter Title';
          popupHintText = 'You cannot enter a blank or invalid title name.';
        }
      } else {
        // user pressed cancel, just return out of the function
        return;
      }
    }

    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => StudyGuidePage(state.user, StudyGuide.newStudyGuide(state.user, userInput)),
    ));
  }
}