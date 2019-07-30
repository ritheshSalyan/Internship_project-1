import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../friends/friend.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../timeline/data.dart';
import 'detailsEdit.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

class FriendDetailBody extends StatelessWidget {
  FriendDetailBody(this.friend);
  final Friend friend;

  List<Widget> completedModule(BuildContext context) {
    List<Widget> completed = [];

    completed.add(Row(
      children:<Widget>[ 
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
    completed.add(
     SizedBox(
       height: 10,
     ));
    for (int item in friend.completed) {
      completed.add(new Card(
        child: Row(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.all(25), //MediaQuery.of(context).size.height * 0.1
              child: Text("Module $item: " + doodles[item - 1].name),
            ),
            Icon(Icons.done_all,color: Colors.green,)
          ],
        ),
      ));
    }
    return completed;
  }

  // Widget _buildCompletednfo(TextTheme textTheme) {
  //   return new Column(
  //     children: completedModule(),
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

  List<Widget> personalDetail(BuildContext context) {
    return <Widget>[
      Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
        child: new Column(
          children: <Widget>[
             Padding(
               padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),
          child: new LinearPercentIndicator(
                width: MediaQuery.of(context).size.width*0.8,
                lineHeight: 14.0,
                percent: friend.completed.length/12,
                animation: true,
                animationDuration: 2500,
                center: Text("${friend.completed.length}/12"),
                backgroundColor: Colors.grey,
                progressColor: Colors.green,
              ),
        ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "Personal Details ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // fontFamily: "Open Sans",
                            color: Colors.green,
                            fontSize: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.3),
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          iconSize: 23,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditDetail(
                                user: friend,
                              ),
                              //  fullscreenDialog: true,
                            ));
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 0,
                    ),
                    child: new Column(
                      children: <Widget>[
                        Card(
                          child: new Padding(
                            padding: EdgeInsets.all(3),
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
                                          friend.email,
                                          style: TextStyle(
                                              // fontFamily: "Open Sans",
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
                                      Icon(Icons.phone_android,
                                          color: Colors.green),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          friend.mobile,
                                          style: TextStyle(
                                              // fontFamily: "Open Sans",
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
                                      Icon(Icons.help_outline,
                                          color: Colors.green),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          friend.gender,
                                          style: TextStyle(
                                              // fontFamily: "Open Sans",
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
                                          friend.institution,
                                          style: TextStyle(
                                              // fontFamily: "Open Sans",
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
                                          friend.occupation,
                                          style: TextStyle(
                                              // fontFamily: "Open Sans",
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
                                      Icon(Icons.feedback, color: Colors.green),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        // child: AutoSizeText(
                                        //   friend.uid,

                                        //   style: TextStyle(
                                        //       // fontFamily: "Open Sans",
                                        //       color: Colors.black,
                                        //       ),

                                        // ),
                                        child: new GestureDetector(
                                          child: new Text(
                                            friend.uid,
                                            style: TextStyle(
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: Colors.blue,
                                                decorationThickness: 1),
                                          ),
                                          onTap: () {
                                            ClipboardManager.copyToClipBoard(
                                                    friend.uid)
                                                .then((result) {
                                              final snackBar = SnackBar(
                                                content:
                                                    Text('Copied to Clipboard'),
                                                action: SnackBarAction(
                                                  label: 'Undo',
                                                  onPressed: () {},
                                                ),
                                              );
                                              Scaffold.of(context)
                                                  .showSnackBar(snackBar);
                                            });
                                          },
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
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    //  var textTheme = theme.textTheme;

    return new Column(
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        
        Column(
          children: personalDetail(context),
        ),
       

        Column(
          children: completedModule(context),
        ),
      ],
    );
  }
}
