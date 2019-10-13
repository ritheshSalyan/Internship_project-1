import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupreneur/NoInternetPage/NoNetPage.dart';
import 'package:startupreneur/models/CommentsAdd.dart';
import 'package:startupreneur/models/chatBoard.dart';

class ViewCommentPage extends StatefulWidget {
  ViewCommentPage(
      {Key key, this.question, this.answers, this.valueData, this.index})
      : super(key: key);
  String question;
  List<ChatBoardData> valueData;
  int index;
  List<CommentsAdd> answers;
  @override
  _ViewCommentPageState createState() => _ViewCommentPageState();
}

class _ViewCommentPageState extends State<ViewCommentPage> {
  String hello =
      "Racana de nobilis fermium, resuscitabo acipenser,Racana de nobilis fermium, resuscitabo acipenser, resuscitabo acipenser  resuscit acipenser ?";
  SharedPreferences sharedPreferences;
  Firestore db;
  String documentId;
  Flushbar<List<String>> flush;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime now = DateTime.now();
  String userId;
  List<String> list = [];
  String text = "";
  String profileLink = "";

  @override
  void initState() {
    super.initState();
    preferences();
    // print("${widget.question}");
    // print("${widget.answers}");
  }

  bool _validate() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateForm(BuildContext context) {
    if (_validate()) {
      saveData(context);
    }
  }

  void saveData(BuildContext context) async {
    list.clear();
    db = Firestore.instance;
    var userName;
    await db
        .collection("user")
        .where("uid", isEqualTo: userId)
        .getDocuments()
        .then((data) {
      data.documents.forEach((document) {
        setState(() {
          profileLink = document.data["profile"];
          userName = document.data['name'];
        });
      });
    });
    CommentsAdd commentsAdd = new CommentsAdd(
      uid: userId,
      comments: text,
      timestamp: now.millisecondsSinceEpoch,
      questionId: widget.valueData[widget.index].uniqId,
      profile: profileLink,
      userName: userName,
    );
    var data = commentsAdd.toJson();
    await db.collection("comments").add(data).then((done) {
      Navigator.of(context).pop();
    });
  }

  void preferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString("UserId");
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
                title: Text("View Comments"),
              ),
              body: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Column(
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
                                    ClipOval(
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor:
                                            Theme.of(context).primaryColorLight,
                                        child: ExtendedImage.network(
                                          widget.valueData[widget.index]
                                              .profileUrl,
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
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: Wrap(
                                          children: <Widget>[
                                            ListTile(
                                              title: Text(
                                                widget.valueData[widget.index]
                                                    .userName,
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              subtitle: AutoSizeText(
                                                widget.question,
                                                maxLines: 50,
                                              ),
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
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          primary: true,
                          padding: const EdgeInsets.all(8.0),
                          itemCount: (widget.answers.length == 0)
                              ? 1
                              : widget.answers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return (widget.answers.isEmpty)
                                ? Center(
                                    child: Text(
                                      "No comments yet",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : ListTile(
                                    leading: ClipOval(
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                            Theme.of(context).primaryColorLight,
                                        child: ExtendedImage.network(
                                          widget.answers[index].profile,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    subtitle:
                                        Text(widget.answers[index].comments),
                                    title: Text(
                                      widget.answers[index].userName,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
//          flushBar(context);
                  // print("hello");
                  flush = Flushbar<List<String>>(
                    userInputForm: Form(
                      autovalidate: true,
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                            autovalidate: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Field cannot be empty";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                text = value;
                              });
                            },
                            style: TextStyle(color: Colors.black),
                            maxLength: 300,
                            maxLines: 3,
                            maxLengthEnforced: true,
                            decoration: InputDecoration(
                              fillColor: Colors.white10,
                              filled: true,
                              border: UnderlineInputBorder(),
                              helperText: "Share Opinion",
                              helperStyle: TextStyle(color: Colors.green),
                              hintText: "Share thoughts with ${widget.valueData[widget.index].userName}",
                              hintStyle: TextStyle(color: Colors.green),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: OutlineButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 10.0,
                                  ),
                                ),
                                textColor: Colors.black,
                                child: Text("Reply"),
                                onPressed: () {
                                  validateForm(context);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // isDismissible: false,
                    backgroundColor: Colors.grey[200],
                  )..show(context).whenComplete(() {
                      // print("done and dusted - 1");
                      flush = Flushbar<List<String>>(
                        backgroundColor: Colors.green,
                        isDismissible: true,
                        duration: Duration(seconds: 3),
                        flushbarPosition: FlushbarPosition.TOP,
                        title: "Reply has been sent",
                        messageText: Column(children: <Widget>[
                          // Text("Successfully added"),
                        ]),
                      )..show(context).whenComplete(() {
                          // print("done and dusted - 2");
                          Navigator.of(context).pushReplacementNamed('/chat');
                        });
                    });
                },
                child: Icon(
                  FontAwesomeIcons.comment,
                ),
                backgroundColor: Colors.green,
                tooltip: "Reply to discussion",
              ),
            );
          }
          return child;
        },
        child: NoNetPage());
  }
}
