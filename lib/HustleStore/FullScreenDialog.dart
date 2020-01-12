import 'package:flutter/material.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs ;
import 'HustleStoreLoader.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AddEntryDialog extends StatefulWidget {
  AddEntryDialog({
    Key key,
    this.points,
    this.available,
    this.descript,
    this.image,
    this.title,
    this.userid,
    this.decision,
    this.len,
  }) : super(key: key);
  int points;
  int available;
  String descript;
  String image;
  String title;
  String userid;
  bool decision;
  int len;
  @override
  AddEntryDialogState createState() => new AddEntryDialogState();
}

class AddEntryDialogState extends State<AddEntryDialog> {
  fs.Firestore db =fb.firestore();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          widget.title.replaceAll("\n", " "),
        ),
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.0000001),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.05),
                    child: Column(
                      children: <Widget>[
                        Image.network(
                          widget.image,
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                        Text(
                          widget.descript.replaceAll(".", ".\n\n"),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "* Please click on Claim Button to avail it for ${widget.points}",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                          color: Colors.green,
                          onPressed: () {
                            setState(() {
                              if (widget.len < 12) {
                                widget.available =
                                    widget.available - widget.points;
                                widget.decision = true;
                                var dataSet = Map<String, dynamic>();
                                dataSet["points"] = widget.available;
                                db
                                    .collection("user")
                                    .doc(widget.userid)
                                    .set(dataSet, fs.SetOptions(merge: true));
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HustleStoreLoader()));
                                print("done");
                              } else {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    elevation: 5.0,
                                    duration: Duration(seconds: 13),
                                    backgroundColor: Colors.green,
                                    content: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/Images/error_idea.png",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02,
                                            ),
                                            child: AutoSizeText(
                                              "Complete all the modules to unlock this Store!\n\nHead to 'Earn Points' to know more.\n\nKeep earning more points to Hustle!",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            });
                          },
                          child: Text("Claim it "),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
