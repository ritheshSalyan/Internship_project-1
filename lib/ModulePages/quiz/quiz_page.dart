import 'package:flutter/material.dart';
import 'package:startupreneur/ModulePages/ModuleTheory/ModuleTheory.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../ModuleOrderController/Types.dart';

class QuizPage extends StatefulWidget {
  QuizPage({Key key, this.modNum, this.order, this.index}) : super(key: key);
  final int modNum, order, index;
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Firestore db = Firestore.instance;

  final TextStyle _questionStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  List<dynamic> options = [];
  int selectedRadio = 0;
  String reason = "";
  String correctAns = "";
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String _answerIs = "";

  @override
  Widget build(BuildContext context) {
    String question = "";
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _key,
        body: Builder(
          builder: (context) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: WaveClipperOne(),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.green),
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
                                  top:
                                      MediaQuery.of(context).size.height * 0.2),
                            ),
                            Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection("quiz")
                                    .where("module", isEqualTo: widget.modNum)
                                    .where("order", isEqualTo: widget.order)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  // if(snapshot.error){
                                  //   print("error");
                                  // }
                                  print(snapshot.data);
                                  switch (snapshot.data) {
                                    case null:
                                      return CircularProgressIndicator();
                                    default:
                                      snapshot.data.documents
                                          .forEach((document) {
                                        question = document["question"];
                                      });
                                      return Text(
                                        question,
                                        textAlign: TextAlign.left,
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
                                    .where("module", isEqualTo: widget.modNum)
                                    .where("order", isEqualTo: widget.order)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  switch (snapshot.data) {
                                    case null:
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: null,
                                          strokeWidth: 3,
                                          valueColor: AlwaysStoppedAnimation(
                                            Colors.green,
                                          ),
                                        ),
                                      );
                                    default:
                                      options.clear();
                                      snapshot.data.documents
                                          .forEach((document) {
                                        correctAns =
                                            document["answer"].toString();
                                        reason = document["reason"];
                                        if (reason.isEmpty) {
                                          reason = "";
                                        } else {
                                          reason = "\n\n " + reason;
                                        }
                                        // print(correctAns);
                                        for (dynamic i in document["option"]) {
                                          options.add(i);
                                        }
                                      });
                                      return ListView.builder(
                                        physics: BouncingScrollPhysics(),
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
                            color: Colors.green,
                            textColor: Colors.white,
                            child: _answerIs.isNotEmpty
                                ? Text("Next")
                                : Text("Submit"),
                            onPressed: () {
                              print("hello $_answerIs");
                              if (_answerIs == correctAns) {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Hurray ! You got it right\n Lets move on !\n" +
                                          reason,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    backgroundColor: Colors.green[600],
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    duration: Duration(hours: 1),
                                    action: SnackBarAction(
                                      textColor: Colors.white,
                                      label: "Ok",
                                      onPressed: () {
                                        // homeScaffoldKey.currentState.hideCurrentSnackBar();
                                        Scaffold.of(context)
                                            .hideCurrentSnackBar();
                                        List<dynamic> arguments = [
                                          widget.modNum,
                                          widget.index + 1
                                        ];
                                        orderManagement.moveNextIndex(
                                            context, arguments);
                                      },
                                    ),
                                  ),
                                );
                                Future.delayed(Duration(seconds: 3)).then((o) {
                                  // List<dynamic> arguments = [
                                  //   widget.modNum,
                                  //   widget.index
                                  // ];
                                  // print("Inside Quiz" + arguments.toString());
                                  // orderManagement.moveNextIndex(
                                  //     context, arguments);
                                });
                              } else {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Oops! Wrong answer",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    backgroundColor: Colors.red[600],
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text("Are you sure you want to quit the quiz? "),
            title: Text(
              "Warning!",
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Yes",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              FlatButton(
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          );
        });
  }
}
