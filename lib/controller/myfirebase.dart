import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import '../model/user.dart';
import '../model/studyguide.dart';
import '../model/quiz.dart';

class MyFirebase {
  // Account Handling
  static Future<String> createAccount({String email, String password}) async {
    var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password
    );

    return result.user.uid;
  }
  static Future<String> login({String email, String password}) async {
    var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.user.uid;
  }
  static void signOut() {
    FirebaseAuth.instance.signOut();
  }

  // Profile Handling
  static void createProfile(User user) async {
    await Firestore.instance.collection(User.PROFILE_COLLECTION)
      .document(user.uid)
      .setData(user.serialize());
  }
  static Future<User> readProfile(String uid) async {
    var doc = await Firestore.instance.collection(User.PROFILE_COLLECTION)
      .document(uid).get();
    return User.deserialize(doc.data);
  }
  static Future<List<User>> readProfileList(List<String> uids) async {
    var userList = List<User>();
    if (uids == null || uids.length == 0) return userList;

    for (var uid in uids) {
      if (uid == null || uid.length == 0) continue;

      var user = await readProfile(uid);
      if (user != null)
        userList.add(user);
    }

    return userList;
  }
  static Future<void> updateProfile(User user) async {
    await Firestore.instance.collection(User.PROFILE_COLLECTION)
      .document(user.uid)
      .setData(user.serialize());
  }

  // Image Handling
  static void uploadProfileImage(File image, String uid) async {
    var ref = FirebaseStorage.instance.ref().child("profile_image/" + uid);
    var task = ref.putFile(image);
    await task.onComplete;
  }
  static Future<String> getProfileImage(String uid) async {
    var ref = FirebaseStorage.instance.ref().child("profile_image/" + uid);
    var uri = (await ref.getDownloadURL()).toString();
    return uri;
  }

  // Study Guide Handling
  static Future<String> addStudyGuide(StudyGuide studyGuide) async {
    var ref = await Firestore.instance.collection(StudyGuide.STUDYGUIDE_COLLECTION)
      .add(studyGuide.serialize());
    return ref.documentID;
  }
  static Future<void> updateStudyGuide(StudyGuide studyGuide) async {
    await Firestore.instance.collection(StudyGuide.STUDYGUIDE_COLLECTION)
      .document(studyGuide.documentId)
      .setData(studyGuide.serialize());
  }
  static Future<StudyGuide> readStudyGuide(String docID) async {
    var doc = await Firestore.instance.collection(StudyGuide.STUDYGUIDE_COLLECTION)
      .document(docID).get();
    return StudyGuide.deserialize(doc.data, docID);
  }

  // returns a list of study guide created by the given user id
  static Future<List<StudyGuide>> getUserStudyGuides(String userID) async {
    var query = await Firestore.instance.collection(StudyGuide.STUDYGUIDE_COLLECTION)
                                .where(StudyGuide.CREATEDBYUID, isEqualTo: userID)
                                .getDocuments();

    var guideList = <StudyGuide>[];
    if (query == null || query.documents.length == 0) return guideList;

    for (var guide in query.documents) {
      guideList.add(StudyGuide.deserialize(guide.data, guide.documentID));
    }

    return guideList;
  }

  // quiz handling
  static Future<String> addQuiz(Quiz quiz) async {
    var ref = await Firestore.instance.collection(Quiz.QUIZ_COLLECTION)
      .add(quiz.serialize());
    return ref.documentID;
  }
  static Future<void> updateQuiz(Quiz quiz) async {
    await Firestore.instance.collection(Quiz.QUIZ_COLLECTION)
      .document(quiz.documentId)
      .setData(quiz.serialize());
  }

  // returns a list of quizzes created by the given user id
  static Future<List<Quiz>> getUserQuizzes(String userID) async {
    var query = await Firestore.instance.collection(Quiz.QUIZ_COLLECTION)
                                .where(Quiz.CREATEDBYUID, isEqualTo: userID)
                                .getDocuments();

    var quizList = <Quiz>[];
    if (query == null || query.documents.length == 0) return quizList;

    for (var quiz in query.documents) {
      quizList.add(Quiz.deserialize(quiz.data, quiz.documentID));
    }

    return quizList;
  }

  // recent activity handling
  static void addToRecentActivityList(User user, String activity) async {
    var activityList = await getRecentActivityList();

    var newActivity = Map<String, dynamic>();
    newActivity["activity"] = user.username + " " + activity;
    newActivity["user"] = user.uid;
    activityList.insert(0, newActivity);

    var updateField = Map<String, dynamic>();
    updateField["activity-list"] = activityList;
    Firestore.instance.collection("meta").document("recent-activity").setData(updateField);
  }

  static Future<List<Map<String, dynamic>>> getRecentActivityList() async {
    var query = await Firestore.instance.collection("meta")
                               .document("recent-activity").get();
    var data = query.data["activity-list"];

    var activityList = List<Map<String, dynamic>>();
    for (var activity in data) {
      var newMap = Map<String, dynamic>();
      newMap["user"] = activity["user"];
      newMap["activity"] = activity["activity"];
      activityList.add(newMap);
    }

    return activityList;
  }
}