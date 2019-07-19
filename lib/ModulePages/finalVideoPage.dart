import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startupreneur/ModulePages/mediaPlayerContent.dart';
import '../timeline/trial.dart';

class videoPlayerPage extends StatefulWidget {
  @override
  videoPlayerPage({Key key, this.title, this.modNum}) : super(key: key);
  final String title;
  final int modNum;
  _videoPlayerPageState createState() => _videoPlayerPageState();
}

class _videoPlayerPageState extends State<videoPlayerPage> {
  Firestore db = Firestore.instance;
  String description = "";
  String link =
      "https://firebasestorage.googleapis.com/v0/b/thestartupreneur-e1201.appspot.com/o/videos%2FVideo%202%20-%20Are%20you%20Ready.mp4?alt=media&token=8edb3441-c5d7-4bd8-9f06-dd8977d65391";

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
              background: VideoApp(link: link),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                // StreamBuilder<QuerySnapshot>(
                //   stream: db
                //       .collection("module")
                //       .where("id", isEqualTo: widget.modNum)
                //       .snapshots(),
                //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //     switch (snapshot.data) {
                //       case null:
                //         return Text("Error");
                //       default:
                //         snapshot.data.documents.forEach((document) {
                //           description = document["content"];
                //         });
                //         return Card(
                //           margin: EdgeInsets.all(10.0),
                //           elevation: 5.0,
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(10.0)),
                //           child: Column(
                //             children: <Widget>[
                //               Padding(
                //                 padding: EdgeInsets.all(20.0),
                //                 child: Text(
                //                   description,
                //                   style: TextStyle(
                //                     fontFamily: "Open Sans",
                //                     fontSize: 16.0,
                //                   ),
                //                 ),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.only(top: 30),
                //                 child: RaisedButton(
                //                   shape: BeveledRectangleBorder(
                //                     borderRadius: BorderRadius.circular(10.0),
                //                   ),
                //                   color: Colors.green,
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                         builder: (context) => IntroScreen(),
                //                       ),
                //                     );
                //                   },
                //                   child: Icon(
                //                     Icons.navigate_next,
                //                     size: 40.0,
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //         );
                //     }
                //   },
                // ),
                RaisedButton(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => TimelinePage(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.navigate_next,
                    size: 40.0,
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
