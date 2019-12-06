import 'package:QuizMe/view/profilepage.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';

class UserListController {
  void viewProfile(BuildContext context, User user, User profileUser) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ProfilePage(user, profileUser);
      }
    ));
  }
}