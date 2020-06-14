import 'package:flutter/material.dart';
import 'package:flutterapp/models/userInfo.dart';

class UserTile extends StatelessWidget {

  final userInfo user;
  UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[user.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(user.name),
          subtitle: Text('Takes ${user.sugars} sugar(s)')
        ),
      )
    );
  }
}
