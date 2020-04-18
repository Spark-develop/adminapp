import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade100,
      child: Center(
          child: SpinKitFadingCube(
        color: Colors.orangeAccent,
        size: 50.0,
      )),
    );
  }
}