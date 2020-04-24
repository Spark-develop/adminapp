import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.stop();
    _controller.reset();
    _controller.repeat(
      period: Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      child: CustomPaint(painter: CurvePainter(), child: temp(context)),
    );
  }

  Widget temp(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        child: CustomPaint(
          painter: CurvePainter(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  topBar(),
                  Text("TYext"),
                  Text("TYext"),
                  Text("TYext"),
                ],
              ),
            ),
          ),
        ));
  }

  Widget topBar() {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
      child: Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  CupertinoIcons.person,
                  color: CupertinoColors.white,
                  size: 42,
                ),
                Icon(
                  CupertinoIcons.gear,
                  color: CupertinoColors.systemGrey,
                  size: 42,
                ),
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  "Home",
                  style: GoogleFonts.poppins(
                    textStyle: CupertinoTheme.of(context).textTheme.textStyle,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CardPainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = CupertinoColors.darkBackgroundGray;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    var path = Path();
    path.moveTo(size.width * 0.55, 0);
    path.quadraticBezierTo(
        size.width * 0.65, size.height * 0.35, 0, size.height * 0.45);
    path.lineTo(0, 0);
    path.lineTo(size.width * 0.55, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = CupertinoColors.systemTeal;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    var path = Path();
    path.moveTo(size.width * 0.59, 0);
    path.quadraticBezierTo(
        size.width * 0.795, size.height * 0.48, 0, size.height * 0.605);
    path.lineTo(0, 0);
    path.lineTo(size.width * 0.55, 0);

    canvas.drawPath(path, paint);
    // var path1 = Path();
    // path1.moveTo(0,size.height* 0.9);
    // path1.quadraticBezierTo(size.width*0.25, size.height*0.875, size.width*0.5, size.height*0.91);
    // path1.quadraticBezierTo(size.width*0.75, size.height*0.95, size.width*1, size.height*0.91);
    // path1.lineTo(size.width, size.height);
    // path1.lineTo(0, size.height);
    // // path1.lineTo(0, size.height*1);
    // // path1.lineTo(0, size.height*0.9);
    // var paint1 = Paint();
    // paint1.style = PaintingStyle.fill;
    // paint1.color = CupertinoColors.systemTeal;
    // canvas.drawPath(path1,paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
