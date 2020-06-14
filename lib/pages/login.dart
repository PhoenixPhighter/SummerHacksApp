import 'package:flutter/material.dart';
import 'package:mvpui/pages/camera.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final myController = TextEditingController();
  final myController2 = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('login screen')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            TextField(
                controller: myController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Username')),
            TextField(
                controller: myController2,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Password')),
            FlatButton.icon(
              onPressed: () {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content:
                            Text(myController.text + " " + myController2.text),
                      );
                    });
              },
              icon: Icon(Icons.arrow_forward),
              label: Text('enter'),
            ),
            FlatButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/camera');
              },
              icon: Icon(Icons.camera),
              label: Text('camera'),
            )
          ],
        ),
      ),
    );
  }
}
