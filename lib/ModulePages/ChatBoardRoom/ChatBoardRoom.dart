import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddChatBoardRoom.dart';
import 'ViewCommentsPage.dart';

class ChatBoardRoom extends StatefulWidget {
  @override
  _ChatBoardRoomState createState() => _ChatBoardRoomState();
}

class _ChatBoardRoomState extends State<ChatBoardRoom> {
  String hello =
      "Racana de nobilis fermium, resuscitabo acipenser,Racana de nobilis fermium, resuscitabo acipenser, resuscitabo acipenser  resuscit acipenser ?";
  String tag = "Module 1";
  Firestore db;
  SharedPreferences sharedPreferences;
  String userId;

  @override
  void initState() {
    super.initState();
    db = Firestore.instance;
    preference();
  }

  void preference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString("UserId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discussion Board"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ViewCommentPage(),
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
                                  hello,
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
                        Text(" ${100}"),
                        SizedBox(
                          width: 25,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.thumbsUp),
                          color: Colors.green,
                        ),
                        Text(" ${100}"),
                        SizedBox(
                          width: 25,
                        ),
                        ActionChip(
                          label: Text(
                            "$tag",
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
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => AddChatBoardRoom(),
                fullscreenDialog: true),
          );
        },
        tooltip: "Click to share thought",
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
