import 'package:flutter/material.dart';
// import '../frienddetails/footer/friend_detail_footer.dart';
import '../frienddetails/friend_detail_body.dart';
import '../frienddetails/header/friend_detail_header.dart';
import '../friends/friend.dart';
import 'package:meta/meta.dart';

class FriendDetailsPage extends StatefulWidget {
  // FriendDetailsPage(
  //   this.friend, {
  //   this.avatarTag,
  // });
  FriendDetailsPage({Key key,this.friend}):super(key:key);
   Friend friend;
  // final Object avatarTag;

  @override
  _FriendDetailsPageState createState() => new _FriendDetailsPageState();
}

class _FriendDetailsPageState extends State<FriendDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // var linearGradient = const BoxDecoration(
    //   gradient: const LinearGradient(
    //     begin: FractionalOffset.centerRight,
    //     end: FractionalOffset.bottomLeft,
    //     colors: <Color>[
    //       const Color(0xFF413070),
    //       const Color(0xFF2B264A),
    //     ],
    //   ),
    // );

    return new Scaffold(
        body: SingleChildScrollView(
      child: CustomPaint(
        painter: BluePainter(),
        child: new SingleChildScrollView(
          child: new Container(
            // decoration: linearGradient,
            child: new Column(
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new FriendDetailHeader(
                  friend:widget.friend,
                  context: context,
                 // avatarTag: widget.avatarTag,
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new FriendDetailBody(widget.friend),
                ),
               
                //new FriendShowcase(widget.friend),
              ],
            ),
          ),
        ),
      ),
    ),);
  }
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.grey[300];
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = new Path();
    // Start paint from 20% height to the left
    ovalPath.moveTo(0, height * 0.4);

    // paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(
        width * 0.5, height * 0.5, width, height * 0.25);


    // draw remaining line to bottom left side
    ovalPath.lineTo(width, 0);
    ovalPath.lineTo(0, 0);

    // Close line to reset it back
    ovalPath.close();

    paint.color = Colors.green;
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
