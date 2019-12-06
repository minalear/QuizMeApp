import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controller/homepage_controller.dart';
import '../model/user.dart';
import '../controller/myfirebase.dart';

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

  List<Map<String, dynamic>> recentActivityList;

  HomePageState(User user) {
    this.user = user;
    controller = HomePageController(this);
    controller.loadRecentActivity();
  }

  void changeState(Function fn) {
    setState(fn);
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
                  imageUrl: (user.profileImageUri == null) ? "" : user.profileImageUri,
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
                title: Text('View Followed Users'),
                onTap: controller.viewFollowerPage,
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
          onPressed: controller.createNew, // create a new study guide or quiz
        ),
        body: (recentActivityList == null || recentActivityList.length == 0) ?
        Center(
          child: Text('No activity found!', textAlign: TextAlign.center)
        ) 
        :
        ListView.builder(
          itemCount: recentActivityList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(5),
              child: ListTile(
                leading: Image.asset('assets/user_icon.png'),
                title: Text(recentActivityList[index]["activity"]),
                onTap: () => controller.viewProfilePage(recentActivityList[index]["user"]),
                onLongPress: (){},
              )
            );
          },
        ),
      )
    );
  }
}