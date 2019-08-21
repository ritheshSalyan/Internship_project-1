import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddChatBoardRoom.dart';
import 'ViewCommentsPage.dart';

class ChatBoardRoom extends StatefulWidget {
  ChatBoardRoom({Key key, this.valueData, this.len}) : super(key: key);

  final List<dynamic> valueData;
  final dynamic len;

  @override
  _ChatBoardRoomState createState() => _ChatBoardRoomState();
}

class _ChatBoardRoomState extends State<ChatBoardRoom> {
  String tag = "Module 1";
  Firestore db;
  String documentId;
  SharedPreferences sharedPreferences;
  dynamic userId;
  List<dynamic> list = [];
  int upvote;
  bool upvoteDecision = false;

  @override
  void initState() {
    super.initState();
    db = Firestore.instance;
    preference().then((user){
      setState(() {
        print("hey user boy $user"); 
        userId = user;
        print("value is ${userId.toString()}");

    print(widget.valueData[0].upvoters.length);
    print(widget.len);

    for (var i = 0; i<=widget.len-1;i++){
      for (var k in  widget.valueData[i].upvoters) {
        list.add(k);
      print(" list ${k}");

      }
      print("hey list ${list[i]}");
    }
    print("hey user $userId");
    for (var j in list) {
      if (j == userId) {
        setState(() {
          upvoteDecision = true;
        });
        print(upvoteDecision);
      }
    }
      });
    });
    
    // fetchingValue();
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
    list.clear();
    for (var k = 0; k <= widget.valueData[index].upvoters.length - 1; k++) {
      list.add(widget.valueData[index].upvoters[k]);
    }
    for (var j in list) {
      if (j == userId) {
        setState(() {
          upvoteDecision = true;
        });
        print(upvoteDecision);
      }
    }
    print(list);
    print("flag is $upvoteDecision");
    if (!upvoteDecision) {
      upvote = widget.valueData[index].upvote;
      if (widget.valueData[index].upvoters.length == 0) {
        list.add(userId);
      } else {
        for (var k = 0; k <= widget.valueData[index].upvoters.length - 1; k++) {
          list.add(widget.valueData[index].upvoters[k]);
        }
         list.add(userId);
      }
      print("hello ${widget.valueData[index].upvoters}");
      print("upvote is $upvote");
      var data = Map<String, dynamic>();
      data["upvote"] = widget.valueData[index].upvoters.length;
      data["upvoters"] = list;
      try {
        await db
            .collection("chat")
            .where("question", isEqualTo: widget.valueData[index].question)
            .getDocuments()
            .then((document) {
          document.documents.forEach((vl) {
            documentId = vl.documentID;
          });
        }).then((val) {
          print("done fetching");
        });
      } catch (e) {
        print(e);
      }

      print("${documentId}");
      print("${upvote}");

      try {
        await db
            .collection("chat")
            .document(documentId)
            .setData(data, merge: true)
            .then((val) {
          print("Done adding");
          initState();
        });
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discussion Board"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.len,
        itemBuilder: (context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ViewCommentPage(
                    question: widget.valueData[index].question,
                    answers: widget.valueData[index].answer,
                  ),
                  fullscreenDialog: true,
                ),
              );
            },
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
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.green,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Wrap(
                              children: <Widget>[
                                AutoSizeText(
                                  widget.valueData[index].question,
                                  maxLines: 50,
                                  textAlign: TextAlign.center,
//                                overflow: TextOverflow.ellipsis,
                                ),
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
                        Text(" ${widget.valueData[index].answer.length - 1}"),
                        SizedBox(
                          width: 25,
                        ),
                        IconButton(
                          onPressed: () {
                            if (upvoteDecision) {
                            } else {
                              increaseUpvote(index);
                            }
                          },
                          icon: Icon(FontAwesomeIcons.thumbsUp),
                          color: (upvoteDecision == true)
                              ? Colors.red
                              : Colors.green,
                        ),
                        Text(" ${widget.valueData[index].upvoters.length}"),
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
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddChatBoardRoom(),
              fullscreenDialog: true,
            ),
          )
              .whenComplete(
            () {
              Future.delayed(Duration(seconds: 5)).then(
                (complete) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ChatBoardRoom(),
                  ));
                },
              );
            },
          );
        },
        tooltip: "Click to share thought",
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
