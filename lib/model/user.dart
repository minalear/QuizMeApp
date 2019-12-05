import 'package:flutter/cupertino.dart';
import 'quiz.dart';
import 'studyguide.dart';

class User {
  String username;
  String email;
  String password;
  String uid;
  String profileImageUri;
  List<String> following;
  List<String> followers;

  List<StudyGuide> studyGuides;
  List<Quiz> quizzes;

  User({
    this.email,
    this.password,
    this.username,
    this.uid,
  });

  Map<String, dynamic> serialize() {
    return <String, dynamic>{
      EMAIL: email,
      USERNAME: username,
      UID: uid,
    };
  }

   static User deserialize(Map<String, dynamic> document) {
    return User (
      email: document[EMAIL],
      username: document[USERNAME],
      uid: document[UID],
    );
  }

  static const PROFILE_COLLECTION = 'userprofile';
  static const EMAIL = 'email';
  static const USERNAME = 'username';
  static const UID = 'uid';
}

