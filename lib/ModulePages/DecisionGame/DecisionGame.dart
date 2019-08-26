import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../ModuleOrderController/Types.dart';

class DecisionGame extends StatefulWidget {
  DecisionGame({Key key, this.modNum, this.order}) : super(key: key);
  final int modNum, order;
  @override
  _DecisionGameState createState() => _DecisionGameState();
}

class _DecisionGameState extends State<DecisionGame> with AutomaticKeepAliveClientMixin {
  Firestore db = Firestore.instance;
  
  final TextStyle _questionStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  List<dynamic> options = [];
  List<dynamic> answers = [];
  int selectedRadio = 0;
  String reason = "";
  String correctAns = "";
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  int _answerIs = 0;
 
 @override
  bool get wantKeepAlive => true;

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
                                    top: MediaQuery.of(context).size.height *
                                        0.2),
                              ),
                              Expanded(
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection("decisionGame")
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
                                      .collection("decisionGame")
                                      .where("module", isEqualTo: widget.modNum)
                                      .where("order", isEqualTo: widget.order)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    switch (snapshot.data) {
                                      case null:
                                        return  Center(
                                          child: CircularProgressIndicator(
                                          value: null,
                                          strokeWidth: 3,
                                          valueColor: AlwaysStoppedAnimation(Colors.green,),
                                        ),
                                        );
                                      default:
                                        options.clear();
                                        
                                        snapshot.data.documents
                                            .forEach((document) {
                                          document["answer"].toString();
                                          for (dynamic i
                                              in document["options"]) {
                                            options.add(i);
                                          }
                                          for (dynamic y
                                              in document["answer"]) {
                                            answers.add(y);
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
                                                  _answerIs = (value);
                                                  options = options;
                                                  answers = answers;
                                                  question = question;
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
                              child: Text("Submit"),
                              onPressed: () {
                                print("hello $_answerIs");
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Column(
                                      
                                      children: <Widget>[
                                        Image.asset('assets/Images/dec.png',
                                        height: MediaQuery.of(context).size.height*0.3,),
                                        Text(
                                      answers[_answerIs],
                                      style: TextStyle(
                                          color: Colors.white,
                                          
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                          
                                    ),
                                      ],
                                    ),
                                    duration: Duration(hours: 1),
                                    backgroundColor: Colors.green[600],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    action: SnackBarAction(
                                      textColor: Colors.white,
                                      label: "Ok",
                                      onPressed: () {
                                        // homeScaffoldKey.currentState.hideCurrentSnackBar();
                                        Scaffold.of(context)
                                            .hideCurrentSnackBar();
                                        List<dynamic> arguments = [
                                          widget.modNum,
                                          widget.order+1
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
          )),
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
