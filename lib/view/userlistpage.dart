import 'package:QuizMe/controller/userlist_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';

class UserListPage extends StatelessWidget {
  final User user;
  final List<User> userList;
  final UserListController controller = UserListController();

  UserListPage(this.user, this.userList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Following List'),
      ),
      body: Center(
        child: (userList == null || userList.length == 0) ? Container(child: Text('No users found!')) :
        ListView.builder(
          itemCount: userList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(5),
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: (userList[index].profileImageUri == null) ? "" : userList[index].profileImageUri,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error_outline, size: 80),
                  width: 80,
                  height: 80,
                ),
                title: Text(userList[index].username),
                onTap: () => controller.viewProfile(context, user, userList[index]),
                onLongPress: (){},
              )
            );
          },
        )
      )
    );
  }
}