import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar defaultAppBar = AppBar(
  iconTheme: IconThemeData(
    color: CupertinoColors.systemTeal,
  ),
  title: Text(
    'Lets Connect',
    style: TextStyle(color: Colors.lightBlueAccent),
  ),
  backgroundColor: Colors.white,
  elevation: 10.0,
  centerTitle: true,
);
