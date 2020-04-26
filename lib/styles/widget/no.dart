
import 'package:flutter/material.dart';

class StatsCounter extends StatelessWidget {
  final double size;
  final int count;
  final String title;
  final Color titleColor;
  final Color tileColor;
  final Route name;
  StatsCounter(
      {@required this.size,
      @required this.count,
      @required this.title,
      this.titleColor = Colors.white,
      this.tileColor = Colors.white,
      this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      // semanticContainer: true,
      elevation: 8.0,
      // width: size,
      // height: size,
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(5.0), color: tileColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(count.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: size * 0.6,
                      fontWeight: FontWeight.w800,
                      color: Colors.black45)),
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: titleColor,
                      fontSize: size * 0.1,
                      fontWeight: FontWeight.w400))
            ]),
      ),
    );
  }
}
