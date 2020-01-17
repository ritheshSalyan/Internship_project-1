import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:flutter_offline/flutter_offline.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupreneur/NoInternetPage/NoNetPage.dart';
import 'package:startupreneur/globalKeys.dart';
import '../../ModuleOrderController/Types.dart';
import '../../saveProgress.dart';

class DecisionGame extends StatefulWidget {
  DecisionGame({Key key, this.modNum, this.order}) : super(key: key);
  final int modNum, order;
  @override
  _DecisionGameState createState() => _DecisionGameState();
}

class _DecisionGameState extends State<DecisionGame>
    with AutomaticKeepAliveClientMixin {
  fs.Firestore db = fb.firestore();

  final TextStyle _questionStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  List<dynamic> options = [];
  List<dynamic> answers = [];
  int selectedRadio;
  String reason = "";
  String correctAns = "";
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  int _answerIs = 0;
  int attempts = 1;
  String documentId;
  SharedPreferences sharedPreferences;

  @override
  bool get wantKeepAlive => true;

  void addToCollection() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("UserId");
    var data = Map<String, dynamic>();
    data['answer'] = options[_answerIs];
    data['attempts'] = attempts;
   db
        .collection("decisionGame")
        .doc(documentId)
        .collection("answers")
        .doc(userId)
        .set(data);
  }

  @override
  Widget build(BuildContext context) {
    String question = "";
    return OfflineBuilder(
      child: NoNetPage(),
      connectivityBuilder:
          (context, ConnectivityResult connectivity, Widget child) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  bottom: 5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Page ${widget.order + 1}/${Module.moduleLength}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                elevation: 0,
                actions: <Widget>[
                  GestureDetector(
                    child: Icon(Icons.home),
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
                                    SaveProgress.preferences(
                                        widget.modNum, widget.order);
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
                            height: MediaQuery.of(context).size.height * 0.3,
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
                                            MediaQuery.of(context).size.height *
                                                0.2),
                                  ),
                                  Expanded(
                                    child: StreamBuilder<fs.QuerySnapshot>(
                                      stream: db
                                          .collection("decisionGame")
                                          .where("module",
                                              "==", widget.modNum)
                                          .where("order",
                                              "==", widget.order)
                                          .onSnapshot,
                                      builder: (context,
                                          AsyncSnapshot<fs.QuerySnapshot>
                                              snapshot) {
                                        // if(snapshot.error){
                                        //   print("error");
                                        // }
                                        print(snapshot.data);
                                        switch (snapshot.data) {
                                          case null:
                                            return CircularProgressIndicator();
                                          default:
                                            snapshot.data.docs
                                                .forEach((document) {
                                              question = document.data()["question"];
                                              documentId = document.id;
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
                                    StreamBuilder<fs.QuerySnapshot>(
                                      stream: db
                                          .collection("decisionGame")
                                          .where("module",
                                              "==", widget.modNum)
                                          .where("order",
                                              "==", widget.order)
                                          .onSnapshot,
                                      builder: (context,
                                          AsyncSnapshot<fs.QuerySnapshot>
                                              snapshot) {
                                        switch (snapshot.data) {
                                          case null:
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: null,
                                                strokeWidth: 3,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                  Colors.green,
                                                ),
                                              ),
                                            );
                                          default:
                                            options.clear();

                                            snapshot.data.docs
                                                .forEach((document) {
                                              document.data()["answer"].toString();
                                              for (dynamic i
                                                  in document.data()["options"]) {
                                                options.add(i);
                                              }
                                              for (dynamic y
                                                  in document.data()["answer"]) {
                                                answers.add(y);
                                              }
                                            });
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: options.length,
                                              itemBuilder: (context, index) {
                                                return RadioListTile(
                                                  activeColor: Colors.black,
                                                  title:
                                                      Text("${options[index]}"),
                                                  groupValue: selectedRadio,
                                                  value: index,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedRadio = value;
                                                      _answerIs = (value);
                                                      options = options;
                                                      answers = answers;
                                                      question = question;
                                                      // _answers[_currentIndex] = value;
                                                      print(
                                                          "answer $_answerIs");
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
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  color: Colors.green,
                                  textColor: Colors.white,
                                  child: Text("Submit"),
                                  onPressed: () {
                                    print("hello $_answerIs");
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Container(
                                          // height: MediaQuery.of(context)
                                          //         .size
                                          //         .height *
                                          //     0.5,
                                          child: AutoSizeText(
                                            answers[_answerIs],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              // fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            // minFontSize: ,
                                            maxLines: 10,
                                          ),
                                        ),
                                        duration: Duration(hours: 1),
                                        backgroundColor: Colors.green[600],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
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
                                              widget.order + 1
                                            ];
                                            orderManagement.moveNextIndex(
                                                context, arguments);
                                          },
                                        ),
                                      ),
                                    );
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
        return child;
      },
    );
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text("Are you sure you want to quit from decision game? "),
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
