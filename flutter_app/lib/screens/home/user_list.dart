import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/models/userInfo.dart';
import 'package:flutterapp/screens/home/user_Tile.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<userInfo>>(context) ?? [];

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserTile(user: users[index]);
      },
    );
  }
}
