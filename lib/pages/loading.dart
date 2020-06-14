import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;

  final double radius = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        width: 100.0,
        height: 100.0,
        child: Center(
            child: Stack(
          children: <Widget>[
            Dot(
              radius: 30.0,
              color: Colors.blueAccent,
            ),
            Transform.translate(
                offset: Offset(radius * cos(pi), radius * sin(pi)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.blue,
                ))
          ],
        )),
      ),
    ));
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(
          color: this.color,
          shape: BoxShape.circle,
        ));
  }
}
