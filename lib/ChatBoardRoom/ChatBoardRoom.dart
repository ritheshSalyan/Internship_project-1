import 'package:extended_image/extended_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:startupreneur/NoInternetPage/NoNetPage.dart';
import 'package:startupreneur/models/CommentsAdd.dart';
import 'package:toast/toast.dart';
import 'AddChatBoardRoom.dart';
import 'ViewCommentsPage.dart';

class ChatBoardRoom extends StatefulWidget {
  ChatBoardRoom({Key key, this.valueData, this.len, this.v}) : super(key: key);

  final List<dynamic> valueData;
  final dynamic len;
  final String v;

  @override
  _ChatBoardRoomState createState() => _ChatBoardRoomState();
}

class _ChatBoardRoomState extends State<ChatBoardRoom> {
  String tag = "Module 1";
  Firestore db;
  dynamic chatSharedUser;
  String documentId;
  SharedPreferences sharedPreferences;
  dynamic userId;
  List<dynamic> upvoters = [];
  int upvote;
  int value;
  List<bool> upvoteDecision = [];
  List<CommentsAdd> list = [];
  CommentsAdd commentsAdd = new CommentsAdd();

  @override
  void initState() {
    super.initState();
    db = Firestore.instance;
    print(widget.valueData);
    upvoters.clear();
    preference().then((user) {
      setState(() {
        userId = user;
        if (widget.len != 0) {
          for (var i = 0; i < widget.len; i++) {
            upvoteDecision.add(false);
            print(upvoteDecision[i]);
          }
        }
      });
    });
    // print(widget.valueData[]);
    Analytics.analyticsBehaviour("Discussion_Chat_Page", "Discussion_Page");
  }

  Future<dynamic> preference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getString("UserId");
    });
    print(userId);
    return userId;
  }

  void increaseUpvote(int index) async {
    upvoters.clear();
    print("from increase $index");
    try {
      await db
          .collection("chat")
          .where("timestamp", isEqualTo: widget.valueData[index].timestamp)
          .getDocuments()
          .then((document) {
        document.documents.forEach((vl) {
          documentId = vl.documentID;
        });
      }).then((val) {
        print("$documentId");
      });
    } catch (e) {
      print(e);
    }
    var data = Map<String, dynamic>();
    //if not null then read the complete array of upvoters and add their userid to it
    if (widget.valueData[index].upvoters.length != 0) {
      for (var j in widget.valueData[index].upvoters) {
        upvoters.add(j);
      }
      upvoters.add(userId);
      data["upvote"] = widget.valueData[index].upvoters.length;
      data["upvoters"] = upvoters;
      try {
        await db
            .collection("chat")
            .document(documentId)
            .setData(data, merge: true)
            .then((val) {
          setState(() {
            value = widget.valueData[index].upvoters.length;
            upvoteDecision[index] = true;
          });
        });
      } catch (e) {}
    } else {
      //if null then just add their user account to upvoters list
      print("imhere");
      upvoters.add(userId);
      data["upvote"] = widget.valueData[index].upvoters.length + 1;
      data["upvoters"] = upvoters;
      try {
        await db
            .collection("chat")
            .document(documentId)
            .setData(data, merge: true)
            .then((val) {
          setState(() {
            value = widget.valueData[index].upvoters.length;
            upvoteDecision[index] = true;
          });
        });
      } catch (e) {}
    }

    // print(widget.valueData[index].upvoters[index]);
  }

  void fetchData(int index, BuildContext context) async {
    await db
        .collection("comments")
        .where('questionId', isEqualTo: widget.valueData[index].uniqId)
        .getDocuments()
        .then((data) {
      data.documents.forEach((value) {
        list.add(CommentsAdd.fromJson(value.data));
      });
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ViewCommentPage(
          question: widget.valueData[index].question,
          answers: list,
          valueData: widget.valueData,
          index: index,
        ),
        fullscreenDialog: false,
      ),
    );
    // Navigator.push(context, )
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder:
          (context, ConnectivityResult connectivity, Widget child) {
        final connected = connectivity != ConnectivityResult.none;
        if (connected) {
          child = Scaffold(
            appBar: AppBar(
              title: Text("Discussion Board"),
            ),
            body: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.len,
              itemBuilder: (context, int index) {
                print(index);
                //to check if the user already given the upvote or not
                if (widget.valueData[index].upvoters.length != 0) {
                  value = widget.valueData[index].upvoters.length;
                  for (var j in widget.valueData[index].upvoters) {
                    if (j == userId) {
                      upvoteDecision[index] = true;
                      break;
                    }
                  }
                }
                return GestureDetector(
                  onTap: () {
                    fetchData(index, context);

                  },
                  // onLongPress: () {
                  //   chatSharedUser = widget.valueData[index].uid;
                  //   if (userId == chatSharedUser) {
                  //     Flushbar(
                  //       titleText: Text(
                  //         "Tools",
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //       messageText: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           IconButton(
                  //             icon: Icon(Icons.delete_outline,
                  //                 color: Colors.black),
                  //             onPressed: () {},
                  //           ),
                  //           IconButton(
                  //             icon: Icon(Icons.edit, color: Colors.black),
                  //             onPressed: () {},
                  //           ),
                  //           IconButton(
                  //             icon: Icon(Icons.share, color: Colors.black),
                  //             onPressed: () {},
                  //           ),
                  //         ],
                  //       ),
                  //       backgroundColor: Colors.transparent,
                  //       duration: Duration(seconds: 5),
                  //       // isDismissible: true,
                  //     )..show(context);
                  //   }
                  //   // return val;
                  // },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 25,
                              ),
                              ClipOval(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      Theme.of(context).primaryColorLight,
                                  child: ExtendedImage.network(
                                    widget.valueData[index].profileUrl,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Wrap(
                                    // alignment: WrapAlignment.center,
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(
                                          (widget.valueData[index].userName ==
                                                  null)
                                              ? "Loading ..."
                                              : widget
                                                  .valueData[index].userName,
                                          // textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        subtitle: AutoSizeText(
                                          (widget.valueData[index].question ==
                                                  null)
                                              ? "Loading ..."
                                              : widget
                                                  .valueData[index].question,
                                          maxLines: 50,
                                          // textAlign: TextAlign.center,
                                        ),
                                      ),
                                      // Column(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.center,
                                      //   children: <Widget>[
                                      //     Text(
                                      //       (widget.valueData[index].userName ==
                                      //               null)
                                      //           ? "Loading ..."
                                      //           : widget
                                      //               .valueData[index].userName,
                                      //       textAlign: TextAlign.center,
                                      //       style: TextStyle(
                                      //           color: Colors.green,
                                      //           fontWeight: FontWeight.w700),
                                      //     ),
                                      //     SizedBox(
                                      //       height: 10,
                                      //     ),
                                      //     AutoSizeText(
                                      //       (widget.valueData[index].question ==
                                      //               null)
                                      //           ? "Loading ..."
                                      //           : widget
                                      //               .valueData[index].question,
                                      //       maxLines: 50,
                                      //       textAlign: TextAlign.center,
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.comment,
                                color: Colors.green,
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: db
                                      .collection("comments")
                                      .where("questionId",
                                          isEqualTo:
                                              widget.valueData[index].uniqId)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<CommentsAdd> list = [];
                                      snapshot.data.documents.forEach((value) {
                                        list.add(CommentsAdd(
                                          uid: value.data['uid'],
                                          comments: value.data['comments'],
                                          timestamp: value.data['timestamp'],
                                          questionId: value.data['questioId'],
                                          profile: value.data['profile'],
                                        ));
                                      });
                                      return Text("${list.length}");
                                    }
                                    return Text("0");
                                  }),
                              SizedBox(
                                width: 25,
                              ),
                              IconButton(
                                onPressed: () {
                                  if (upvoteDecision[index]) {
                                    //do nothing
                                    Toast.show("Already upvoted !", context);
                                  } else {
                                    increaseUpvote(index);
                                  }
                                },
                                icon: Icon(FontAwesomeIcons.thumbsUp),
                                color: (upvoteDecision[index] == true)
                                    ? Colors.grey
                                    : Colors.green,
                              ),
                              (value != null)
                                  ? Text(
                                      " ${widget.valueData[index].upvoters.length}",
                                    )
                                  : Text("${0}"),
                              SizedBox(
                                width: 25,
                              ),
                              ActionChip(
                                label: Text(
                                  "${widget.valueData[index].tag}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {},
                                backgroundColor: Colors.green,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => AddChatBoardRoom(),
                    fullscreenDialog: true,
                  ),
                );
                // .whenComplete(
                //   () {
                //     Future.delayed(Duration(seconds: 5)).then(
                //       (complete) {
                //         Navigator.of(context).pushReplacement(MaterialPageRoute(
                //           builder: (context) => ChatBoardRoomLoader(),
                //         ));
                //       },
                //     );
                //   },
                // );
              },
              tooltip: "Click to share thought",
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
            ),
          );
        }
        return child;
      },
      child: NoNetPage(),
    );
  }
}
