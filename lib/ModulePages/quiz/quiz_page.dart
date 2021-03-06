import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/globalKeys.dart';
import '../../ModuleOrderController/Types.dart';

class QuizPage extends StatefulWidget {
  QuizPage({Key key, this.modNum, this.order, this.index}) : super(key: key);
  final int modNum, order, index;
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Firestore db = Firestore.instance;
  // static final _formkey = GlobalKey<FormState>();
  final TextStyle _questionStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  SharedPreferences sharedPreferences;
  int attempts = 0;
  String documentId;
  List<dynamic> options = [];
  int selectedRadio;
  String reason = "";
  List<String> correctAns;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String _answerIs = "";

  @override
  void initState() {
    super.initState();
    Analytics.analyticsBehaviour("Quiz_Page", "Quiz_Page");
  }

  void addToCollection() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("UserId");
    var data = Map<String, dynamic>();
    data['answer'] = options[int.parse(_answerIs)];
    data['attempts'] = attempts;
    Firestore.instance
        .collection("quiz")
        .document(documentId)
        .collection("answers")
        .document(userId)
        .setData(data);
  }

  @override
  Widget build(BuildContext context) {
    String question = "";
    return CustomeOffline(
      onConnetivity: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          //    bottomSheet: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: <Widget>[
          //     Text(
          //       "Page ${widget.index+1}/${Module.moduleLength}",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(color: Colors.green),
          //     ),
          //   ],
          // ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              bottom: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Page ${widget.index + 1}/${Module.moduleLength}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            // backgroundColor: Colors.white,
            elevation: 0,
            actions: <Widget>[
              GestureDetector(
                child: Icon(
                  Icons.home,
                ),
                onTap: () {
                  showDialog<bool>(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          content: Text(
                              "Are you sure you want to return to Home Page? "),
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
                                // Navigator.of(context).popUntil(ModalRoute.withName("/QuoteLoading"));
                                Navigator.of(context).popUntil(
                                    ModalRoute.withName("TimelinePage"));
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
                },
              ),
            ],
          ),
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
                                    top: MediaQuery.of(context).size.height *
                                        0.1),
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
                                          documentId = document.documentID;
                                        });
                                        // return Row(
                                        //   children: <Widget>[
                                        return Text(
                                          question,
                                          textAlign: TextAlign.left,
                                          style: _questionStyle,
                                        );

                                      //   ],
                                      // );
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
                                          correctAns = document["answer"]
                                              .toString()
                                              .split(",");
                                          reason = document["reason"];
                                          if (reason.isEmpty) {
                                            reason = "";
                                          } else {
                                            reason = reason;
                                          }
                                          // print(correctAns);
                                          for (dynamic i
                                              in document["option"]) {
                                            options.add(i);
                                          }
                                        });
                                        return ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          // reverse: true,
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
                                                  _answerIs =
                                                      (value).toString();
                                                  print(
                                                      "answer ${options[int.parse(_answerIs)]}");
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
                                // if (_answerIs == correctAns) {
                                if (correctAns.contains(_answerIs)) {
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "You’ve got it Right\n\n" + reason,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      backgroundColor: Colors.green[600],
                                      shape: BeveledRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      duration: Duration(hours: 1),
                                      action: SnackBarAction(
                                        textColor: Colors.white,
                                        label: "Ok",
                                        onPressed: () {
                                          addToCollection();
                                          // homeScaffoldKey.currentState.hideCurrentSnackBar();
                                          Scaffold.of(context)
                                              .hideCurrentSnackBar();
                                          List<dynamic> arguments = [
                                            widget.modNum,
                                            widget.index
                                          ];
                                          orderManagement.moveNextIndex(
                                              context, arguments);
                                        },
                                      ),
                                    ),
                                  );
                                  // Future.delayed(Duration(seconds: 3)).then((o) {
                                  //   // List<dynamic> arguments = [
                                  //   //   widget.modNum,
                                  //   //   widget.index
                                  //   // ];
                                  //   // print("Inside Quiz" + arguments.toString());
                                  //   // orderManagement.moveNextIndex(
                                  //   //     context, arguments);
                                  // });
                                } else {
                                  setState(() {
                                    attempts += 1;
                                  });
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Hmm, not quite right but definitely an interesting perspective",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      backgroundColor: Colors.red[600],
                                      shape: BeveledRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
