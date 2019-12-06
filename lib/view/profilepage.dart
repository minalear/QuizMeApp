import 'package:QuizMe/controller/profilepage_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';

class ProfilePage extends StatefulWidget {
  final User profileUser;
  final User user;
  ProfilePage(this.user, this.profileUser);

  @override 
  State<StatefulWidget> createState() {
    return ProfilePageState(user, profileUser);
  }
}

class ProfilePageState extends State<ProfilePage> {

  User user;
  User profileUser;
  ProfilePageController controller;

  ProfilePageState(this.user, this.profileUser) {
    controller = ProfilePageController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: (profileUser.profileImageUri == null) ? "" : profileUser.profileImageUri,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error_outline, size: 250),
              width: 250,
              height: 250,
            ),
            Container(
              child: Center(child: Text(profileUser.username, style: TextStyle(fontSize: 35))),
              padding: EdgeInsets.only(top: 10),
            ),
            Container(child: Center(child: Text(profileUser.email))),
            RaisedButton(
              child: Text('See All Quizzes'),
              onPressed: controller.seeRecentQuizzes,
            ),
            RaisedButton(
              child: Text('See All Study Guides'),
              onPressed: controller.seeRecentStudyGuides,
            ),
            RaisedButton(
              child: Text('Follow User'),
              onPressed: controller.followUser,
            )
          ],
        ),
      )
    );
  }
}