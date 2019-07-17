import 'package:flutter/material.dart';
import 'package:startupreneur/ModulePages/mediaPlayerContent.dart';

class videoPlayerPage extends StatefulWidget {
  @override
  videoPlayerPage({Key key,this.title}):super(key:key);
  final String title;
  _videoPlayerPageState createState() => _videoPlayerPageState();
}

class _videoPlayerPageState extends State<videoPlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            primary: true,
            backgroundColor: Theme.of(context).primaryColorDark,
            // automaticallyImplyLeading: false,
            expandedHeight: 350,
            title: Text(
              widget.title,
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
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
                      ListTile(
                        leading: Icon(Icons.arrow_forward_ios,size:20,),
                        title: Text(
                          "How are Ideas Generated",
                          textAlign: TextAlign.left,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.arrow_forward_ios,size:20,),
                        title: Text(
                           "Learn,Learn,Learn",
                          textAlign: TextAlign.left,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.arrow_forward_ios,size:20,),
                        title: Text(
                          "Market research",
                          textAlign: TextAlign.left,
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
                      ListTile(
                        leading: Icon(Icons.arrow_forward_ios,size:20,),
                        title: Text(
                          "Primary path to new business idea",
                          textAlign: TextAlign.left,
                        ),
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
                      ListTile(
                        leading: Icon(Icons.arrow_forward_ios,size:20,),
                        title: Text(
                           "Why you want to start-up (Questioning Character)",
                          textAlign: TextAlign.left,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.arrow_forward_ios,size:20,),
                        title: Text(
                           "Myths busted",
                          textAlign: TextAlign.left,
                        ),
                      ),
                      // Text(
                      //   "Why you want to start-up (Questioning Character)",
                      //   textAlign: TextAlign.left,
                      // ),
                      // Text(
                      //   "Myths busted",
                      //   textAlign: TextAlign.left,
                      // ),
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
                      ListTile(
                        leading: Icon(Icons.arrow_forward_ios,size:20,),
                        title: Text(
                           "What to avoid ?",
                          textAlign: TextAlign.left,
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
    );
  }
}
