import 'package:flutter/material.dart';
import 'package:startupreneur/ModulePages/videoPlay.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'quiz_finished.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class QuizPage extends StatefulWidget {
  QuizPage({Key key,this.modNum}):super(key:key);
  final int modNum;
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Firestore db = Firestore.instance;

  final TextStyle _questionStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white);
  List<dynamic> options = [];
  int _currentIndex = 0;
  int selectedRadio = 0;
  String reason = "";
  String correctAns = "";
  final Map<int, dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String _answerIs = "";

  

  @override
  Widget build(BuildContext context) {
    String question = "";
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _key,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.grey),
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(width: 16.0),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.2),
                        ),
                        Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection("quiz")
                                .where("module", isEqualTo: 1)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              // if(snapshot.error){
                              //   print("error");
                              // }
                              print(snapshot.data);
                              switch (snapshot.data) {
                                case null:
                                  return Text("hello");
                                default:
                                  snapshot.data.documents.forEach((document) {
                                    question = document["question"];
                                  });
                                  return Text(
                                    question,
                                    style: _questionStyle,
                                  );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          StreamBuilder<QuerySnapshot>(
                            stream: db
                                .collection("quiz")
                                .where("module", isEqualTo: 1)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              switch (snapshot.data) {
                                case null:
                                  return Text("No data available");
                                default:
                                  options.clear();
                                  snapshot.data.documents.forEach((document) {
                                    correctAns = document["answer"].toString();
                                    reason = document["reason"];
                                    // print(correctAns);
                                    for (dynamic i in document["option"]) {
                                      options.add(i);
                                    }
                                  });
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      return RadioListTile(
                                        activeColor: Colors.black,
                                        title: Text("${options[index]}"),
                                        groupValue: selectedRadio,
                                        value: index,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedRadio = value;
                                            _answerIs = (value).toString();
                                            // _answers[_currentIndex] = value;
                                            print("answer $_answerIs");
                                          });
                                        },
                                      );
                                    },
                                  );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: _answerIs.isNotEmpty
                            ? Text("Next")
                            : Text("Submit"),
                        onPressed: () {
                          print("hello $_answerIs");
                          if (_answerIs == correctAns) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context)=>videoPlayerPage(title:"What is Startup",modNum:widget.modNum)
                              )
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void _nextSubmit() {
  //   if(_answers[_currentIndex] == null) {
  //     _key.currentState.showSnackBar(SnackBar(
  //       content: Text("You must select an answer to continue."),
  //     ));
  //     return;
  //   }
  //   if(_currentIndex < (widget.questions.length - 1)){
  //     setState(() {
  //         _currentIndex++;
  //     });
  //   } else {
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (_) => QuizFinishedPage(questions: widget.questions, answers: _answers)
  //     ));
  //   }
  // }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(
                "Are you sure you want to quit the quiz? All your progress will be lost."),
            title: Text("Warning!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          );
        });
  }
}
