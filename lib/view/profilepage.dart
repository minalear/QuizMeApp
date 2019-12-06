import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../controller/utilities.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  ProfilePage(this.user);

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
            Column(
              children: user.studyGuides.map((data) {
                return Container(
                  padding: EdgeInsets.all(5),
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: 'http://meganandtimmy.com/wp-content/uploads/2012/03/tan-index-card-hi.png',
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error_outline),
                    ),
                    title: Text(data.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('by ' + data.createdBy),
                        Text(dateTimeFormat(data.pubDate, 'yyyy-MM-dd')),
                      ],
                    ),
                    //onTap: () => controller.viewStudyGuide(user.quizzes[index]),
                    onTap: () => (){},
                    onLongPress: (){},
                  )
                );
              }).toList(),
            )
          ],
        )
        /*child: ListView.builder(
          itemCount: user.quizzes.length,
          itemBuilder: (BuildContext context, int index) {
            
          },
        )
      )*/
      /*body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
          ],
        ),
      ),*/
      )
    );
  }
}