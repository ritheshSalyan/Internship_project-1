import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startupreneur/ChatBoardRoom/ChatBoardRoom.dart';

class ChatRoom {
  String question;
  String tag;
  dynamic upvote;
  List<dynamic> answer;
  List<dynamic> upvoters;

  ChatRoom({
    this.answer,
    this.question,
    this.tag,
    this.upvote,
    this.upvoters,
  });
}

class ChatBoardRoomLoader extends StatefulWidget {
  @override
  _ChatBoardRoomLoaderState createState() => _ChatBoardRoomLoaderState();
}

class _ChatBoardRoomLoaderState extends State<ChatBoardRoomLoader> {
  Firestore db;
  List<ChatRoom> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fetchDataStorage().then(
      (data) {
        print("${data.length}");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ChatBoardRoom(
              valueData: data,
              len: data.length,
              v:"hello",
            ),
          ),
        );
      },
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              strokeWidth: 5,
              value: null,
              valueColor: new AlwaysStoppedAnimation(Colors.green),
            ),
            SizedBox(
              height: 10,
            ),
            Material(
              color: Colors.transparent,
              child: Text(
                "Loading...",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<dynamic>> fetchDataStorage() async {
    db = Firestore.instance;
    list.clear();
    await db.collection("chat").getDocuments().then((document) {
      document.documents.forEach((value) {
        list.add(new ChatRoom(
          answer: value.data["answers"],
          upvote: value.data["upvote"],
          tag: value.data["tag"],
          question: value.data["question"],
          upvoters: value.data["upvoters"],
        ));
      });
    });
    // print(list[0].upvoters);
    return list;
  }
}
