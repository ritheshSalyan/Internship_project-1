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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 50), 
        child:new Text(
          "Progress",
          style: TextStyle(
            fontSize: 20,color: Colors.black,fontFamily: "Open Sans"
          ),
        ),
        ),
        new Padding(
              padding: EdgeInsets.all(15.0),
              child: new Row(
               children: <Widget>[ 
                 new LinearPercentIndicator(
                width: MediaQuery.of(context).size.width*0.65,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2500,
                percent: 0.8,
                center: Text("80.0%",
                style: TextStyle(fontFamily: "Open Sans",color: Colors.black),
                ),
                
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.green,
              ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: new Text("80.0%",
              //   style: TextStyle(fontFamily: "Open Sans",color: Colors.black),
              //   ),
              // )
               ],
               ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Column(
            children: <Widget>[
              Text("Personal Details ",
              style: TextStyle(fontFamily: "Open Sans",color: Colors.black,fontSize: 18),
              ),
              Padding( 
              padding: EdgeInsets.only(left:50,
                                        top: 10),
              child:new Column(
                children: <Widget>[ 
                  new Column( 
                    children: <Widget>[ 
                      Text("data@email.com",
                      style: TextStyle(fontFamily: "Open Sans",color: Colors.black,fontSize: 16),
                      ),
                      Text("data@email.com",
                      style: TextStyle(fontFamily: "Open Sans",color: Colors.black,fontSize: 16),
                      ),
                      Text("data@email.com",
                      style: TextStyle(fontFamily: "Open Sans",color: Colors.black,fontSize: 16),
                      ),
                    ],
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
