import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:startupreneur/NoInternetPage/NoNetPage.dart';
import 'package:startupreneur/timeline/data.dart';
// import '../frienddetails/footer/friend_detail_footer.dart';
import '../frienddetails/friend_detail_body.dart';
import '../frienddetails/header/friend_detail_header.dart';
import '../friends/friend.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: size.height,
          child: SingleChildScrollView(
                      child: Wrap(
              
              children: <Widget>[
                Container(
                    color: Colors.green,
                    child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Wrap(
                        
                        alignment: WrapAlignment.center,
                        direction: Axis.vertical,
                        children: <Widget>[
                          _buildAvatar(),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Text(widget.friend.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.shortestSide * 0.05)),
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/Images/coins.png",
                                width:
                                    MediaQuery.of(context).size.shortestSide * 0.025,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(widget.friend.points.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                         Row(
                            children: <Widget>[
                              Icon(
                                
                                Icons.email,
                                color: Colors.white,
                                size:
                                    MediaQuery.of(context).size.shortestSide * 0.025,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(widget.friend.email,
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                         Row(
                            children: <Widget>[
                              Icon(
                                
                                Icons.help_outline,
                                color: Colors.white,
                                size:
                                    MediaQuery.of(context).size.shortestSide * 0.025,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(widget.friend.gender,
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                           Row(
                            children: <Widget>[
                              Icon(
                                
                                Icons.business,
                                color: Colors.white,
                                size:
                                    MediaQuery.of(context).size.shortestSide * 0.025,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(widget.friend.institution,
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                
                                Icons.phone,
                                color: Colors.white,
                                size:
                                    MediaQuery.of(context).size.shortestSide * 0.025,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(widget.friend.mobile,
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                           Row(
                            children: <Widget>[
                              Icon(
                                
                                Icons.supervised_user_circle,
                                color: Colors.white,
                                size:
                                    MediaQuery.of(context).size.shortestSide * 0.025,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(widget.friend.ventureName,
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                     
                          SizedBox(
                            height: size.height * 0.1,
                          )
                        ],
                      ),
                    )),
                Container(
                    width: size.width*0.75,
                    // color: Colors.blueGrey,
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,

                      children:completedModule(context),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );

    // return new Scaffold(
    //   body:SingleChildScrollView(
    //           child: new Container(
    //             child: CustomPaint(
    //               painter: BluePainter(),
    //               child: new Column(
    //                 children: <Widget>[
    //                   new FriendDetailHeader(
    //                     friend: widget.friend,
    //                     context: context,
    //                   ),
    //                   new Padding(
    //                     padding: const EdgeInsets.all(10.0),
    //                     child: new FriendDetailBody(widget.friend),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),

    // );
  }

  Widget _buildAvatar() {
    return new GestureDetector(
      onTap: () {
        // getFilePath(context);
      },
      child: new Hero(
        tag: 1,
        child: new CircleAvatar(
//          backgroundImage: new NetworkImage(friend.avatar),
          backgroundImage: NetworkImage(widget.friend.avatar),
          radius: 65.0,
          // child:
          //  Padding(
          //     padding: EdgeInsets.only(
          //         top: MediaQuery.of(context).size.height * 0.14,
          //         left: MediaQuery.of(context).size.width * 0.15),
          //     child: IconButton(
          //       icon: Icon(
          //         Icons.edit,
          //         color: Colors.white,
          //         size: 30,
          //       ),
          //       onPressed: () {
          //         // getFilePath(context);
          //       },
          //     )),
        ),
      ),
    );
  }

   List<Widget> completedModule(BuildContext context) {
    List<Widget> completed = [];

    completed.add(Row(
      children: <Widget>[
        SizedBox(
          width: 15,
        ),
        Text(
          "Completed Modules",
          style: TextStyle(
              fontSize: 20,
              color: Colors.green,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.5),
        ),
      ],
    ));
    completed.add(SizedBox(
      height: 10,
    ));
    int i = 0;
    for (int item in widget.friend.completed) {
      i++;
      // print("*******************"+); 
      completed.add(Padding(
        padding: EdgeInsets.all(10),
        child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width*0.23,
          child: Padding(
            padding:
                EdgeInsets.all(MediaQuery.of(context).size.width * 0.03), 
             
          child: Row(
            children: <Widget>[
              Text("Module $i: "),
              doodles[i-1].name, 
              SizedBox(
                width: 0.1,
              ),
               Icon(
            Icons.done_all,
            color: Colors.green,
          )
            ],
          ),
          ),
        ),
      )
      ));
    }
    return completed;
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
