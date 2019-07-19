import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../casestudy/loading.dart';
import 'package:startupreneur/ModulePages/mediaPlayerContent.dart';

class videoPlayerPage extends StatefulWidget {
  @override
  videoPlayerPage({Key key, this.title,this.modNum}) : super(key: key);
  final String title;
  final int modNum;
  _videoPlayerPageState createState() => _videoPlayerPageState();
}

class _videoPlayerPageState extends State<videoPlayerPage> {
  Firestore db = Firestore.instance;
  String description = "";
  String link =
      "https://firebasestorage.googleapis.com/v0/b/thestartupreneur-e1201.appspot.com/o/videos%2FVideo%201%20-%20What%20is%20a%20Startup.mp4?alt=media&token=e3df2e48-4475-4889-a5a0-7f42217a5073";

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
                StreamBuilder<QuerySnapshot>(
                  stream: db
                      .collection("module")
                      .where("id", isEqualTo: widget.modNum)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    switch (snapshot.data) {
                      case null:
                        return Text("Error");
                      default:
                        snapshot.data.documents.forEach((document) {
                          description = document["content"];
                        });
                        return Card(
                          margin: EdgeInsets.all(10.0),
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  description,
                                  style: TextStyle(
                                    fontFamily: "Open Sans",
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: RaisedButton(
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Colors.green,
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => Loading(),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.navigate_next,
                                    size: 40.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
