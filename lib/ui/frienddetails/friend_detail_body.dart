import 'package:flutter/material.dart';
import '../friends/friend.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FriendDetailBody extends StatelessWidget {
  FriendDetailBody(this.friend);
  final Friend friend;

  // Widget _buildLocationInfo(TextTheme textTheme) {
  //   return new Row(
  //     children: <Widget>[
  //       new Icon(
  //         Icons.place,
  //         color: Colors.white,
  //         size: 16.0,
  //       ),
  //       new Padding(
  //         padding: const EdgeInsets.only(left: 8.0),
  //         child: new Text(
  //           friend.location,
  //           style: textTheme.subhead.copyWith(color: Colors.white),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _createCircleBadge(IconData iconData, Color color) {
  //   return new Padding(
  //     padding: const EdgeInsets.only(left: 8.0),
  //     child: new CircleAvatar(
  //       backgroundColor: color,
  //       child: new Icon(
  //         iconData,
  //         color: Colors.white,
  //         size: 16.0,
  //       ),
  //       radius: 16.0,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    //  var textTheme = theme.textTheme;

    return new Column(
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        // Padding(
        //   padding: EdgeInsets.only(top: 60),
        // child:new Card(
        //     child: new Padding(
        //         padding: EdgeInsets.all(15),
        //           child: new Text(
        //     "Progress",
        //     style: TextStyle(
        //       fontSize: 20,color: Colors.black,fontFamily: "Open Sans"
        //     ),
        //   ),
        //     ),
        // ),
        // ),
        // new Padding(
        //       padding: EdgeInsets.all(15.0),
        //       child: new Row(
        //        children: <Widget>[
        //          new LinearPercentIndicator(
        //         width: MediaQuery.of(context).size.width*0.65,
        //         animation: true,
        //         lineHeight: 20.0,
        //         animationDuration: 2500,
        //         percent: 0.8,
        //         center: Text("80.0%",
        //         style: TextStyle(fontFamily: "Open Sans",color: Colors.black),
        //         ),

        //         linearStrokeCap: LinearStrokeCap.roundAll,
        //         progressColor: Colors.green,
        //       ),
        //       // SingleChildScrollView(
        //       //   scrollDirection: Axis.horizontal,
        //       //   child: new Text("80.0%",
        //       //   style: TextStyle(fontFamily: "Open Sans",color: Colors.black),
        //       //   ),
        //       // )
        //        ],
        //        ),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: new Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Personal Details ",
                  style: TextStyle(
                      fontFamily: "Open Sans",
                      color: Colors.green,
                      fontSize: 20
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0, top: 10),
                child: new Column(
                  children: <Widget>[
                    Card(
                      child: new Padding(
                        padding: EdgeInsets.only(left: 0, top: 5),
                        child: new Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: new Row(
                                children: <Widget>[
                                  Icon(Icons.email, color: Colors.green),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "data@email.com",
                                      style: TextStyle(
                                          fontFamily: "Open Sans",
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: new Row(
                                children: <Widget>[
                                  Icon(Icons.phone_android, color: Colors.green),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "9966332255",
                                      style: TextStyle(
                                          fontFamily: "Open Sans",
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: new Row(
                                children: <Widget>[
                                  Icon(Icons.help_outline, color: Colors.green),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Female",
                                      style: TextStyle(
                                          fontFamily: "Open Sans",
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: new Row(
                                children: <Widget>[
                                  Icon(Icons.business, color: Colors.green),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "School of AI",
                                      style: TextStyle(
                                          fontFamily: "Open Sans",
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                             Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: new Row(
                                children: <Widget>[
                                  Icon(Icons.work, color: Colors.green),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Student",
                                      style: TextStyle(
                                          fontFamily: "Open Sans",
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
