import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tags/tag.dart';
import 'package:startupreneur/models/chatBoard.dart';
import 'package:startupreneur/progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

class AddChatBoardRoom extends StatefulWidget {
  @override
  _AddChatBoardRoomState createState() => _AddChatBoardRoomState();
}

class _AddChatBoardRoomState extends State<AddChatBoardRoom> {
  List<String> tags = [];
  String text = "";
  String userId;
  Firestore db;
  ProgressDialog progressDialog;
  DateTime now = DateTime.now();
  bool _isTapped1 = false;
  bool _isTapped2 = false;
  bool _isTapped3 = false;
  bool _isTapped4 = false;
  bool _isTapped5 = false;
  bool _isTapped6 = false;
  bool _isTapped7 = false;
  bool _isTapped8 = false;
  bool _isTapped9 = false;
  bool _isTapped10 = false;
  bool _isTapped11 = false;
  bool _isTapped12 = false;
  bool _isTapped13 = false;
  bool _isTapped14 = false;
  bool _isTappedG = false;
  bool _isChecked = false;
  static final _formkey = GlobalKey<FormState>();
  SharedPreferences sharedPreferences;
  var uuid = new Uuid();

  @override
  void initState() {
    super.initState();
    preference();
    tags.clear();
    print(now.millisecondsSinceEpoch);
  }

  static bool _validate() {
    final form = _formkey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void preference() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      userId = sharedPreferences.getString("UserId");
    });
  }

  void addDiscussion(BuildContext context) async {
    // ChatBoardData chatBoardData = ChatBoardData();
    progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
    progressDialog.setMessage("Adding question");
    progressDialog.show();
    db = Firestore.instance;
    var profileUrl;
    var userName;
    print(text);
    print(userId);
    print(text);

    var data = await db
        .collection("user")
        .where("uid", isEqualTo: userId)
        .getDocuments();

    data.documents.forEach((value) {
      profileUrl = value.data["profile"];
      userName = value.data["name"];
    });

    ChatBoardData chatBoardData = new ChatBoardData(
      uid: userId,
      tag: tags[0],
      upvote: 0,
      upvoters: [],
      timestamp: now.millisecondsSinceEpoch,
      question: text,
      uniqId: uuid.v1(),
      profileUrl: profileUrl,
      userName: userName,
    );
    var message = chatBoardData.toJson();
    print(message);

    await db.collection("chat").add(message).then((done) {
      print(done);
      progressDialog.hide();
      Navigator.of(context).pushReplacementNamed('/chat');
    });
  }

  void validate(BuildContext context) {
    if (_validate()) {
      addDiscussion(context);
    }
    print("text is $text");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add topic"),
        ),
        body: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Card(
                    elevation: 8.0,
                    child: Column(
                      children: <Widget>[
                        Form(
                          autovalidate: true,
                          key: _formkey,
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              TextFormField(
                                keyboardType: TextInputType.text,
                                onSaved: (value) {
                                  setState(() {
                                    print("$value");
                                    text = value;
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    print("empty");
                                    return "Field cannot be empty";
                                  }
                                  return null;
                                },
                                maxLines: 3,
                                maxLength: 300,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    FontAwesomeIcons.comment,
                                    color: Colors.green,
                                  ),
                                  hintText: "Whats in your mind",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Tags(
                                    runSpacing: 10,
                                    itemCount: tags.length,
                                    itemBuilder: (int index) {
                                      return ItemTags(
                                        activeColor: Colors.green,
                                        pressEnabled: false,
                                        combine: ItemTagsCombine.withTextBefore,
                                        removeButton: ItemTagsRemoveButton(),
                                        onRemoved: () {
                                          // Remove the item from the data source.
                                          setState(() {
                                            // required
                                            tags.clear();
                                            _isChecked = false;
                                            _isTapped1 = false;
                                            _isTapped2 = false;
                                            _isTapped3 = false;
                                            _isTapped4 = false;
                                            _isTapped5 = false;
                                            _isTapped6 = false;
                                            _isTapped7 = false;
                                            _isTapped8 = false;
                                            _isTapped9 = false;
                                            _isTapped10 = false;
                                            _isTapped11 = false;
                                            _isTapped12 = false;
                                            _isTapped13 = false;
                                            _isTapped14 = false;
                                            _isTappedG = false;
                                          });
                                        },
                                        index: index,
                                        title: tags[index],
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    OutlineButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                          color: Colors.green,
                                          width: 3,
                                        ),
                                      ),
                                      onPressed: () {
                                        validate(context);
                                      },
                                      child: Row(
                                        children: <Widget>[
//                        Icon(FontAwesomeIcons.comment),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Share thoughts",
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Title(
                    color: Colors.green,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.tags,
                          size: 10,
                        ),
                        Text(
                          " Tags",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Card(
                    elevation: 8.0,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ActionChip(
                              label: Text("Module 1"),
                              elevation: 5.0,
                              onPressed: () {
                                setState(() {
                                  if (_isChecked) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("One tag can be selected"),
                                    ));
                                  } else {
                                    tags.add("Module 1");
                                    _isChecked = true;
                                    _isTapped1 = true;
                                  }
                                  print(tags);
                                });
                              },
                              labelStyle: TextStyle(color: Colors.white),
                              backgroundColor: (_isChecked && _isTapped1)
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                            ActionChip(
                              elevation: 5.0,
                              label: Text("Module 2"),
                              onPressed: () {
                                setState(() {
                                  if (_isChecked) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("One tag can be selected"),
                                    ));
                                  } else {
                                    tags.add("Module 2");
                                    _isChecked = true;
                                    _isTapped2 = true;
                                  }
                                  print(tags);
                                });
                              },
                              labelStyle: TextStyle(color: Colors.white),
                              backgroundColor: (_isChecked && _isTapped2)
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                            ActionChip(
                              elevation: 5.0,
                              label: Text("Module 3"),
                              onPressed: () {
                                setState(() {
                                  if (_isChecked) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("One tag can be selected"),
                                    ));
                                  } else {
                                    tags.add("Module 3");
                                    _isChecked = true;
                                    _isTapped3 = true;
                                  }
                                  print(tags);
                                });
                              },
                              labelStyle: TextStyle(color: Colors.white),
                              backgroundColor: (_isChecked && _isTapped3)
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ActionChip(
                              elevation: 5.0,
                              label: Text("Module 4"),
                              onPressed: () {
                                setState(() {
                                  if (_isChecked) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("One tag can be selected"),
                                    ));
                                  } else {
                                    tags.add("Module 4");
                                    _isChecked = true;
                                    _isTapped4 = true;
                                  }
                                  print(tags);
                                });
                              },
                              labelStyle: TextStyle(color: Colors.white),
                              backgroundColor: (_isChecked && _isTapped4)
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                            ActionChip(
                              elevation: 5.0,
                              label: Text("Module 5"),
                              onPressed: () {
                                setState(() {
                                  if (_isChecked) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("One tag can be selected"),
                                    ));
                                  } else {
                                    tags.add("Module 5");
                                    _isChecked = true;
                                    _isTapped5 = true;
                                  }
                                  print(tags);
                                });
                              },
                              labelStyle: TextStyle(color: Colors.white),
                              backgroundColor: (_isChecked && _isTapped5)
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                            ActionChip(
                              elevation: 5.0,
                              label: Text("Module 6"),
                              onPressed: () {
                                setState(() {
                                  if (_isChecked) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("One tag can be selected"),
                                    ));
                                  } else {
                                    tags.add("Module 6");
                                    _isChecked = true;
                                    _isTapped6 = true;
                                  }
                                  print(tags);
                                });
                              },
                              labelStyle: TextStyle(color: Colors.white),
                              backgroundColor: (_isChecked && _isTapped6)
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ActionChip(
                              elevation: 5.0,
                              label: Text("Module 7"),
                              onPressed: () {
                                setState(() {
                                  if (_isChecked) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("One tag can be selected"),
                                    ));
                                  } else {
                                    tags.add("Module 7");
                                    _isChecked = true;
                                    _isTapped7 = true;
                                  }
                                  print(tags);
                                });
                              },
                              labelStyle: TextStyle(color: Colors.white),
                              backgroundColor: (_isChecked && _isTapped7)
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                            ActionChip(
                              elevation: 5.0,
                              label: Text("Module 8"),
                              onPressed: () {
                                setState(() {
                                  if (_isChecked) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("One tag can be selected"),
                                    ));
                                  } else {
                                    tags.add("Module 8");
                                    _isChecked = true;
                                    _isTapped8 = true;
                                  }
                                  print(tags);
                                });
                              },
                              labelStyle: TextStyle(color: Colors.white),
                              backgroundColor: (_isChecked && _isTapped8)
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                            ActionChip(
                              elevation: 5.0,
                              label: Text("Module 9"),
                              onPressed: () {
                                setState(() {
                                  if (_isChecked) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("One tag can be selected"),
                                    ));
                                  } else {
                                    tags.add("Module 9");
                                    _isChecked = true;
                                    _isTapped9 = true;
                                  }
                                  print(tags);
                                });
                              },
                              labelStyle: TextStyle(color: Colors.white),
                              backgroundColor: (_isChecked && _isTapped9)
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ActionChip(
                              elevation: 5.0,
                              label: Text("Module 10"),
                              onPressed: () {
                                setState(() {
                                  if (_isChecked) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("One tag can be selected"),
                                    ));
                                  } else {
                                    tags.add("Module 10");
                                    _isChecked = true;
                                    _isTapped10 = true;
                                  }
                                  print(tags);
                                });
                              },
                              labelStyle: TextStyle(color: Colors.white),
                              backgroundColor: (_isChecked && _isTapped10)
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                            ActionChip(
                              elevation: 5.0,
                              label: Text("Module 11"),
                              onPressed: () {
                                setState(() {
                                  if (_isChecked) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("One tag can be selected"),
                                    ));
                                  } else {
                                    tags.add("Module 11");
                                    _isChecked = true;
                                    _isTapped11 = true;
                                  }
                                  print(tags);
                                });
                              },
                              labelStyle: TextStyle(color: Colors.white),
                              backgroundColor: (_isChecked && _isTapped11)
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                            ActionChip(
                              elevation: 5.0,
                              label: Text("Module 12"),
                              onPressed: () {
                                setState(() {
                                  if (_isChecked) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("One tag can be selected"),
                                    ));
                                  } else {
                                    tags.add("Module 12");
                                    _isChecked = true;
                                    _isTapped12 = true;
                                  }
                                  print(tags);
                                });
                              },
                              labelStyle: TextStyle(color: Colors.white),
                              backgroundColor: (_isChecked && _isTapped12)
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ActionChip(
                              elevation: 5.0,
                              label: Text("Module 13"),
                              onPressed: () {
                                setState(() {
                                  if (_isChecked) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("One tag can be selected"),
                                    ));
                                  } else {
                                    tags.add("Module 13");
                                    _isChecked = true;
                                    _isTapped13 = true;
                                  }
                                  print(tags);
                                });
                              },
                              labelStyle: TextStyle(color: Colors.white),
                              backgroundColor: (_isChecked && _isTapped13)
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                            ActionChip(
                              elevation: 5.0,
                              label: Text("Module 14"),
                              onPressed: () {
                                setState(() {
                                  if (_isChecked) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("One tag can be selected"),
                                    ));
                                  } else {
                                    tags.add("Module 14");
                                    _isChecked = true;
                                    _isTapped14 = true;
                                  }
                                  print(tags);
                                });
                              },
                              labelStyle: TextStyle(color: Colors.white),
                              backgroundColor: (_isChecked && _isTapped14)
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                            ActionChip(
                              elevation: 5.0,
                              label: Text("General"),
                              onPressed: () {
                                setState(() {
                                  if (_isChecked) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("One tag can be selected"),
                                    ));
                                  } else {
                                    tags.add("General");
                                    _isChecked = true;
                                    _isTappedG = true;
                                  }
                                  print(tags);
                                });
                              },
                              labelStyle: TextStyle(color: Colors.white),
                              backgroundColor: (_isChecked && _isTapped12)
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     ActionChip(
                        //       elevation: 5.0,
                        //       label: Text("General"),
                        //       onPressed: () {
                        //         setState(() {
                        //           if (_isChecked) {
                        //             Scaffold.of(context).showSnackBar(SnackBar(
                        //               content: Text("One tag can be selected"),
                        //             ));
                        //           } else {
                        //             tags.add("General");
                        //             _isChecked = true;
                        //             _isTappedG = true;
                        //           }
                        //           print(tags);
                        //         });
                        //       },
                        //       labelStyle: TextStyle(color: Colors.white),
                        //       backgroundColor: (_isChecked && _isTappedG)
                        //           ? Colors.grey
                        //           : Colors.green,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
