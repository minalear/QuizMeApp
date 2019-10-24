import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';

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


}