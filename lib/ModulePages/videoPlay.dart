import 'package:flutter/material.dart';
import 'package:startupreneur/timeline/trial.dart';
import 'package:startupreneur/ModulePages/mediaPlayerContent.dart';

class videoPlayerPage extends StatefulWidget {
//  videoPlayerPage({Key key,this.placeValue}):super(key:key);
//  final int placeValue;

  @override
  _videoPlayerPageState createState() => _videoPlayerPageState();
}

class _videoPlayerPageState extends State<videoPlayerPage> {
  @override
  Widget build(BuildContext context) {
//    final doodle = doodles[widget.placeValue];
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            primary: false,
            backgroundColor: Theme.of(context).primaryColorDark,
//            leading: IconButton(
//              icon: Icon(
//                Icons.arrow_back,
//                color: Colors.black,
//              ),
//              onPressed: () {
//                Navigator.of(context).pop(
//                  MaterialPageRoute(
//                    builder: (context) => TimelinePage(
//                      title: "Road Map",
//                    ),
//                  ),
//                );
//              },
//            ),
            automaticallyImplyLeading: true,
            expandedHeight: 350,
            title: Text(
              "Module 1",
              style: TextStyle(color: Colors.black),
            ),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: VideoApp(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Container(
                  child: Text(
                    "Course Overview",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ExpansionTile(
                    leading: Icon(Icons.looks_one),
                    title: Text(
                      "How to build an Idea for your start-up",
                      style: TextStyle(color: Colors.green),
                    ),
                    children: <Widget>[
                      Divider(
                        color: Colors.green,
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "How are Ideas Generated",
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "Learn,Learn,Learn",
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "Market research",
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ExpansionTile(
                    leading: Icon(Icons.looks_two),
                    title: Text(
                      "Paths to a business Idea",
                      style: TextStyle(color: Colors.green),
                    ),
                    children: <Widget>[
                      Text(
                        "Three primary paths to a new business idea",
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ExpansionTile(
                    leading: Icon(Icons.looks_3),
                    title: Text(
                      "Why do you want startup",
                      style: TextStyle(color: Colors.green),
                    ),
                    children: <Widget>[
                      Text(
                        "Why you want to start-up (Questioning Character)",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Myths busted",
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ExpansionTile(
                    leading: Icon(Icons.looks_4),
                    title: Text(
                      "Which is best for you",
                      style: TextStyle(color: Colors.green),
                    ),
                    children: <Widget>[
                      Text(
                        "What to avoid ? ",
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
