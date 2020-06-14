import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvpui/pages/login.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('camera screen')),
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              icon: Icon(Icons.lock),
              label: Text('login'),
            ),
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.photo_camera),
              label: Text('take picture'),
            ),
          ],
        ),
      ),
    );
  }
}
