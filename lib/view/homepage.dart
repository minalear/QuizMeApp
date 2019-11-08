import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controller/homepage_controller.dart';
import '../model/user.dart';
import '../controller/utilities.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage(this.user);

  @override
  State<StatefulWidget> createState() {
    return HomePageState(user);
  }
}

class HomePageState extends State<HomePage> {
  User user;
  HomePageController controller;
  List<int> toDeleteIndices;

  HomePageState(User user) {
    this.user = user;
    controller = HomePageController(this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){ return Future.value(false); },
      child: Scaffold(
        appBar: AppBar(
          title: Text('User Home'),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(user.username),
                accountEmail: Text(user.email),
                currentAccountPicture: CachedNetworkImage(
                  imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHkxm4rKAN-JerP0Nbo9m698yZoRuvJpATZjo2WQc8L3Z_sGsW&s',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error_outline),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('My Profile'),
                onTap: controller.myProfile,
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: Text('Shared With Me'),
                onTap: (){},
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sign Out'),
                onTap: controller.signOut,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: controller.createNewStudyGuide,
        ),
        body: (user.studyGuides == null || user.studyGuides.length == 0) ?
        Center(
          child: Text('No study guides found!', textAlign: TextAlign.center)
        ) 
        :
        ListView.builder(
          itemCount: user.studyGuides.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(5),
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: 'http://meganandtimmy.com/wp-content/uploads/2012/03/tan-index-card-hi.png',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error_outline),
                ),
                title: Text(user.studyGuides[index].title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('by ' + user.studyGuides[index].createdBy),
                    Text(dateTimeFormat(user.studyGuides[index].pubDate, 'yyyy-MM-dd')),
                  ],
                ),
                onTap: () => controller.viewStudyGuide(user.studyGuides[index]),
                onLongPress: (){},
              )
            );
          },
        ),
      )
    );
  }
}