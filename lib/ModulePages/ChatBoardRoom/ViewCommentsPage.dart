import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewCommentPage extends StatefulWidget {
  @override
  _ViewCommentPageState createState() => _ViewCommentPageState();
}

class _ViewCommentPageState extends State<ViewCommentPage> {
  String hello =
      "Racana de nobilis fermium, resuscitabo acipenser,Racana de nobilis fermium, resuscitabo acipenser, resuscitabo acipenser  resuscit acipenser ?";
  SharedPreferences sharedPreferences;
  Firestore db;

  String userId;

  @override
  void initState() {
    super.initState();
    preferences();
  }

  void preferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString("UserId");
  }

  Widget snackbar(BuildContext context) => SnackBar(
        content: Row(
          children: <Widget>[
            Text("hello"),
          ],
        ),
      );

  Widget buildInput(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          // Button send image
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 15.0),
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () {},
                color: Theme.of(context).primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border: new Border(
              top: new BorderSide(
                  color: Theme.of(context).primaryColor, width: 0.5)),
          color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Comments"),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
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
                      ],
                    ),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.green,
                      ),
                      title: Text(hello),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
//            buildInput(context),
              ],
            ),
          ),
          buildInput(context),
        ],
      ),
//          floatingActionButton: FloatingActionButton(
//            onPressed: () {},
//            child: Icon(
//              FontAwesomeIcons.comment,
//            ),
//            backgroundColor: Colors.green,
//            tooltip: "Reply to discussion",
//          ),
//          bottomSheet: BottomSheet(
//              onClosing: () {},
//              builder: (context) {
//                return Container(
//                  padding: const EdgeInsets.only(left: 20, right: 5),
//                  width: MediaQuery.of(context).size.width * .85,
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(20),
//                    color: Colors.white,
//                  ),
//                  child: new Row(
//                    children: <Widget>[
//                      new Flexible(
//                        child: new TextField(
//                          decoration: new InputDecoration.collapsed(
//                            hintText: "Ask a question",
//                          ),
//                        ),
//                      ),
//                      new Container(
//                        child: new IconButton(
//                          icon: new Icon(
//                            Icons.send,
//                            color: Color(0xff2139b1),
//                          ),
//                          onPressed: () {},
//                        ),
//                      )
//                    ],
//                  ),
//                );
//              }),
    );
  }
}
