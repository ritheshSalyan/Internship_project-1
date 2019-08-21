import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupreneur/ChatBoardRoom/ChatBoardRoomLoader.dart';
import 'AddChatBoardRoom.dart';
import 'ViewCommentsPage.dart';

class ChatRoom {
  String question;
  String tag;
  dynamic upvote;
  List<dynamic> answer;

  ChatRoom({
    this.answer,
    this.question,
    this.tag,
    this.upvote,
  });
}

class ChatBoardRoom extends StatefulWidget {

  ChatBoardRoom({Key key,this.valueData,this.len}):super(key:key);

   final List<dynamic> valueData;
   final dynamic len;

  @override
  _ChatBoardRoomState createState() => _ChatBoardRoomState();
}

class _ChatBoardRoomState extends State<ChatBoardRoom> {
  String hello =
      "Racana de nobilis fermium, resuscitabo acipenser,Racana de nobilis fermium, resuscitabo acipenser, resuscitabo acipenser  resuscit acipenser ?";
  String tag = "Module 1";
  Firestore db;
  String documentId;
  SharedPreferences sharedPreferences;
  String userId;
  int upvote;
  List<ChatRoom> chatroom = [];

  @override
  void initState() {
    super.initState();
    db = Firestore.instance;
    preference();

    print(widget.len);
    // fetchingValue();
  }

  void preference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString("UserId");
  }

  // void fetchingValue() async {
  //   chatroom.clear();
  //   db = Firestore.instance;
  //   await db.collection("chat").getDocuments().then((document) {
  //     document.documents.forEach((value) {
  //       chatroom.add(new ChatRoom(
  //         question: value.data["question"],
  //         answer: value.data["answers"],
  //         tag: value.data["tag"],
  //         upvote: value.data["upvote"],
  //       ));
  //     });
  //   });
  //   print(chatroom.length);
  // }

  void increaseUpvote(int index) async {
    upvote = widget.valueData[index].upvote;
    print("upvote is $upvote");
    var data = Map<String, dynamic>();
    data["upvote"] = widget.valueData[index].upvote + 1;
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
    print("${documentId}");
    print("${upvote}");
    await db
        .collection("chat")
        .document(documentId)
        .setData(data, merge: true)
        .then((val) {
      print("Done adding");
      initState();
    });
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
                    answers:widget.valueData[index].answer,
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
                            increaseUpvote(index);
                          },
                          icon: Icon(FontAwesomeIcons.thumbsUp),
                          color: Colors.green,
                        ),
                        Text(" ${widget.valueData[index].upvote}"),
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
