import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs ;
import 'package:startupreneur/ChatBoardRoom/ChatBoardRoom.dart';
import 'package:startupreneur/models/chatBoard.dart';
// import 'package:firebase_database/firebase_database.dart';



class ChatBoardRoomLoader extends StatefulWidget {
  @override
  _ChatBoardRoomLoaderState createState() => _ChatBoardRoomLoaderState();
}

class _ChatBoardRoomLoaderState extends State<ChatBoardRoomLoader> {
  fs.Firestore db;
  List<ChatBoardData> list = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fetchDataStorage().then(
      (data) {
        // print("${data.length}");
        // print(data);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ChatBoardRoom(
              valueData: data,
              len: data.length,
              v: "hello",
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
                "Loading... Please Wait",
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

  Future<List<ChatBoardData>> fetchDataStorage() async {
    db =fb.firestore();
    list.clear();
    await db
        .collection("chat")
        .orderBy("timestamp", "desc")
        .get()
        .then((documentSnapshot) {
      documentSnapshot.docs.forEach((data) {
        list.add(
          ChatBoardData.fromJson(data.data()),
        );
      });
      // list.add(new ChatRoom(
      //   answer: value.data["answers"],
      //   upvote: value.data["upvote"],
      //   tag: value.data["tag"],
      //   question: value.data["question"],
      //   upvoters: value.data["upvoters"],
      //   timestamp: value.data["timestamp"],
      //   uid: value.data["uid"],
      //   comments: value.data["Comments"],
      // ));
    });
    // print(list[0].upvoters);
    return list;
  }
}
