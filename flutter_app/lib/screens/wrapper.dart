import 'package:flutter/material.dart';
import 'package:flutterapp/screens/authenticate/authenticate.dart';
import 'package:flutterapp/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user == null){
      return Authenticate();
    } else{
      return Home();
    }
    // return either home or authenticate widget
  }
}
