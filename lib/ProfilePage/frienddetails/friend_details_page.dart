import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:startupreneur/NoInternetPage/NoNetPage.dart';
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
  FriendDetailsPage({Key key, this.friend}) : super(key: key);
  Friend friend;
  // final Object avatarTag;

  @override
  _FriendDetailsPageState createState() => new _FriendDetailsPageState();
}

class _FriendDetailsPageState extends State<FriendDetailsPage> {

  
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Analytics.analyticsBehaviour("User_Profile_page", "Profile_Page");
  }

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
      body: OfflineBuilder(
        connectivityBuilder:
            (context, ConnectivityResult connectivity, Widget child) {
          final connected = connectivity != ConnectivityResult.none;
          if (connected) {
            child = new SingleChildScrollView(
              child: new Container(
                child: CustomPaint(
                  painter: BluePainter(),
                  child: new Column(
                    children: <Widget>[
                      new FriendDetailHeader(
                        friend: widget.friend,
                        context: context,
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new FriendDetailBody(widget.friend),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return child;
        },
        child: NoNetPage(),
      ),
    );
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
    paint.color = Colors.grey[200];
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = new Path();
    // Start paint from 20% height to the left
    ovalPath.moveTo(0, 350);

    // paint a curve from current position to middle of the screen
    // ovalPath.quadraticBezierTo(
    //     width * 0.5, height * 0.35, width, height * 0.2);

    ovalPath.lineTo(width, 350);
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
