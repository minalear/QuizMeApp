import 'quiz.dart';
import 'studyguide.dart';

class User {
  String username;
  String email;
  String password;
  String uid;
  String profileImageUri;
  List<String> following;

  List<StudyGuide> studyGuides;
  List<Quiz> quizzes;

  User({
    this.email,
    this.password,
    this.username,
    this.uid,
    this.following,
  });

  Map<String, dynamic> serialize() {
    return <String, dynamic>{
      EMAIL: email,
      USERNAME: username,
      UID: uid,
      FOLLOWING: following
    };
  }

   static User deserialize(Map<String, dynamic> document) {
    var followingList = List<String>();
    
    if (document[FOLLOWING] != null) {
      for (var user in document[FOLLOWING]) {
        followingList.add(user.toString());
      }
    }

    return User (
      email: document[EMAIL],
      username: document[USERNAME],
      uid: document[UID],
      following: followingList,
    );
  }

  static const PROFILE_COLLECTION = 'userprofile';
  static const EMAIL = 'email';
  static const USERNAME = 'username';
  static const UID = 'uid';
  static const FOLLOWING = 'following';
}

