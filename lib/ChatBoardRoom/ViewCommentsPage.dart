import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupreneur/ChatBoardRoom/ChatBoardRoomLoader.dart';

class ViewCommentPage extends StatefulWidget {
  ViewCommentPage({Key key, this.question, this.answers}) : super(key: key);
  String question;
  List<dynamic> answers;
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
  String userId;
  List<String> list = [];
  String text = "";

  @override
  void initState() {
    super.initState();
    preferences();
    print("${widget.question}");
    print("${widget.answers.length}");
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
    await db
        .collection("chat")
        .where("question", isEqualTo: widget.question)
        .getDocuments()
        .then((document) {
      document.documents.forEach((id) {
        documentId = id.documentID;
      });
    });
    for (dynamic i in widget.answers) {
      list.add(i);
    }
    list.add(text);
    var data = Map<String, dynamic>();
    data["answers"] = list;
    await db
        .collection("chat")
        .document(documentId)
        .setData(data, merge: true)
        .then((done) {
      Navigator.of(context).pop();
      // initState();
      // setState(() {});
    });
  }

  void preferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString("UserId");
  }

  TextFormField getFormField(String text) {
    return TextFormField(
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
        hintText: text,
        hintStyle: TextStyle(color: Colors.green),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                      widget.question,
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
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  padding: const EdgeInsets.all(8.0),
                  itemCount: widget.answers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return (widget.answers[index] == "")
                        ? Container()
                        : ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.green,
                            ),
                            title: Text(widget.answers[index]),
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
          print("hello");
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
                      hintText: "Share thoughts",
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
                print("done and dusted - 1");
                flush = Flushbar<List<String>>(
                  isDismissible: true,
                  duration: Duration(seconds: 3),
                  flushbarPosition: FlushbarPosition.TOP,
                  title: "Success",
                  messageText: Column(children: <Widget>[
                    Text("Successfully added"),
                  ]),
                )..show(context)
              .whenComplete(() {
                    print("done and dusted - 2");
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ChatBoardRoomLoader(),
                    ));
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
}
