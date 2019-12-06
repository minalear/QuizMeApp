import 'package:QuizMe/controller/profilepage_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../controller/utilities.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  ProfilePage(this.user);

  @override 
  State<StatefulWidget> createState() {
    return ProfilePageState(user);
  }
}

class ProfilePageState extends State<ProfilePage> {

  User user;
  ProfilePageController controller;
  ProfilePageState(this.user) {
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
              imageUrl: (user.profileImageUri == null) ? "" : user.profileImageUri,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error_outline, size: 250),
              width: 250,
              height: 250,
            ),
            Container(
              child: Center(child: Text(user.username, style: TextStyle(fontSize: 35))),
              padding: EdgeInsets.only(top: 10),
            ),
            Container(child: Center(child: Text(user.email))),
            RaisedButton(
              child: Text('See All Quizzes'),
              onPressed: controller.seeRecentQuizzes,
            ),
            RaisedButton(
              child: Text('See All Study Guides'),
              onPressed: controller.seeRecentStudyGuides,
            ),
          ],
        ),
      )
    );
  }
}