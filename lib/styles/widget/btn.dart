import 'package:flutter/material.dart';

class IndicatorButton extends StatelessWidget {
  final double height;
  final String title;
  final Function onTap;
  final int indicationCount;

  const IndicatorButton({this.height = 50.0, this.title, this.onTap, this.indicationCount});

  bool get hasIndication => indicationCount != null && indicationCount > 0;

  @override
  Widget build(BuildContext context) {
    return 
       Card(
        color: Colors.lightBlueAccent,
        elevation: 6.0,
        child: InkWell(
          onTap: onTap,
                  child: Stack(children: [
          Container(
              height: height,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), ),
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: Colors.black45),
              )),
          hasIndication ? Positioned(
            top: 10,
            right: 20.0,
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration:
                  ShapeDecoration(shape: CircleBorder(), color: Colors.white70),
              child: Text(indicationCount.toString(),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            ),
          ) : Container()
      ]),
        ),
    // )
    );
  }
}