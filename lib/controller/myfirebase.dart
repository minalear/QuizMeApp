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
  static Future<void> updateProfile(User user) async {
    await Firestore.instance.collection(User.PROFILE_COLLECTION)
      .document(user.uid)
      .setData(user.serialize());
  }

  // Image Handling
  static Future<String> uploadProfileImage(File image, String uid) async {
    var ref = FirebaseStorage.instance.ref().child("profile_image/" + uid);
    var task = ref.putFile(image);
    var snapshot = await task.onComplete;
    return snapshot.ref.getDownloadURL().toString();
  }
  static Future<NetworkImage> getProfileImage(String uid) async {
    var ref = FirebaseStorage.instance.ref().child("profile_image/" + uid);
    var uri = (await ref.getDownloadURL()).toString();
    print("URI ===> " + uri);
    return NetworkImage(uri);
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
}