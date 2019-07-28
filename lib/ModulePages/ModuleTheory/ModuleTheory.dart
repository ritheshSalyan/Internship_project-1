import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../VideoController/VideoController.dart';
import '../../ModuleOrderController/Types.dart';

class videoPlayerPage extends StatefulWidget {
  @override
  videoPlayerPage({Key key, this.title, this.modNum,this.index}) : super(key: key);
  final String title;
  final int modNum,index;
  _videoPlayerPageState createState() => _videoPlayerPageState();
}

class _videoPlayerPageState extends State<videoPlayerPage> {
  Firestore db = Firestore.instance;
  String description = "";
  // String link =
  //     "https://firebasestorage.googleapis.com/v0/b/startupreneur-ace66.appspot.com/o/videos%2Fwhat%20is%20startup%20720p.mp4?alt=media&token=5761962c-27a0-4cf1-ab78-c037feff769d";

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
            expandedHeight: MediaQuery.of(context).size.height*0.2,
            title: Text(
              widget.title,
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                background: ClipPath(
              clipper: WaveClipperOne(),
            )),
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
                              Container(
                                width: MediaQuery.of(context).size.height*0.3,
                                child: Padding(
                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Colors.green,
                                  onPressed: () {
                                     List<dynamic> arguments = [widget.modNum,widget.index+1];
                                    orderManagement.moveNextIndex(context, arguments);
                                  },
                                  child: Icon(
                                    Icons.navigate_next,
                                    size: 40.0,
                                  ),
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