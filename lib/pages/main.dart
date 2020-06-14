import 'package:flutter/material.dart';
import 'package:mvpui/pages/camera.dart';
import 'package:mvpui/pages/loading.dart';
import 'package:mvpui/pages/login.dart';

void main() => runApp(MaterialApp(initialRoute: '/camera', routes: {
      '/': (context) => Loading(),
      '/camera': (context) => Camera(),
      '/login': (context) => Login(),
    }));
