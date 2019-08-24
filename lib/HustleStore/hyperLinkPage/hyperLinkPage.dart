import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../HustleStoreLoader.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';

class AddEntryDialogHyperLink extends StatefulWidget {
  AddEntryDialogHyperLink({
    Key key,
    this.points,
    this.available,
    this.descript,
    this.image,
    this.title,
    this.userid,
    this.claimedUser,
    // this.decision,
    this.len,
    this.type,
    this.link,
  }) : super(key: key);
  int points;
  int available;
  String descript;
  String image;
  String title;
  String type;
  String link;
  List<dynamic> claimedUser =[];
  String userid;
  // bool decision;
  int len;
  @override
  AddEntryDialogState createState() => new AddEntryDialogState();
}

class AddEntryDialogState extends State<AddEntryDialogHyperLink> {
  Firestore db = Firestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init ${widget.claimedUser}");
    // SchedulerBinding.instance.addPostFrameCallback((_){
    //     Flushbar(
    //       isDismissible: true,
    //       title: "Hello world",
    //       message: "hey manh ",
    //     )..show(context);
    //   });
  }

  launcher(String urlLink) async {
    String url = urlLink;
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {

    
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          "Know More"
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
                        Image.asset(
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
                          "* Click 'Claim it' for ${widget.points} points or go back to the goldmine and explore other exciting mines.",
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
                              if (widget.len == 12) {
                                  launcher(widget.link);
                                // widget.claimedUser.add(widget.userid);
                                // widget.available =
                                //     widget.available - widget.points;
                                // var dataSet = Map<String, dynamic>();
                                // dataSet["points"] = widget.available;
                                //  var data = Map<String, dynamic>();
                                // data["claimed"] = widget.claimedUser;
                                // db
                                //     .collection("user")
                                //     .document(widget.userid)
                                //     .setData(dataSet, merge: true);
                                // db.collection("storeDetails").where("type",isEqualTo: widget.type).getDocuments().then((doc){
                                //   doc.documents.forEach((val){
                                //     db.collection("storeDetails").document(val.documentID).setData(data,merge: true);
                                //   });
                                // });
                                // Navigator.of(context).pushReplacement(
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             HustleStoreLoader()));
                                // print("done");
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
