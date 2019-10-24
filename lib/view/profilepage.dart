import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHkxm4rKAN-JerP0Nbo9m698yZoRuvJpATZjo2WQc8L3Z_sGsW&s',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error_outline, size: 250),
              width: 250,
              height: 250,
            ),
            Container(
              child: Text(user.username, style: TextStyle(fontSize: 35)),
              padding: EdgeInsets.only(top: 10),
            ),
            Container(child: Text(user.email)),
          ],
        ),
      ),
    );
  }
}