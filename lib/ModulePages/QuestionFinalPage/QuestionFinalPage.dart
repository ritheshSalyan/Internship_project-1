import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:startupreneur/ModulePages/VideoController/VideoController.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/timeline/MainRoadmap.dart';

import '../../saveProgress.dart';

class QuestionFinalPage extends StatefulWidget {
  @override
  _QuestionFinalPageState createState() => _QuestionFinalPageState();
}

class _QuestionFinalPageState extends State<QuestionFinalPage> {
  static final _formkey = GlobalKey<FormState>();

  bool _validate() {
    final form = _formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  validateAndSubmit(BuildContext context) async {
    if (_validate()) {
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) =>
         return  new RevealPage();
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    // CustomeOffline(
    //       onConnetivity:
           Scaffold(
        //      bottomSheet: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: <Widget>[
        //     Text(
        //       "${}",
        //       textAlign: TextAlign.center,
        //       style: TextStyle(color: Colors.green),
        //     ),
        //   ],
        // ),
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
                              //  SaveProgress.preferences(
                              //         widget.modNum, widget.index);
                              // Navigator.of(context).popUntil(ModalRoute.withName("/QuoteLoading"));
                              // Navigator.of(context)
                              //     .popUntil(ModalRoute.withName("TimelinePage"));
                               Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => TimelinePage()),
                            );
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
        body: SingleChildScrollView(
          child: Builder(
            builder: (context) {
              return Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: WaveClipperOne(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                      ),
                      height: 150,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Think and answer!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.5,
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Card(
                                elevation: 0.0,
                                clipBehavior: Clip.antiAlias,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "If you want to Startup, then, what would be your reason for starting up?",
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Form(
                          key: _formkey,
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              TextFormField(
                                autovalidate: true,
                                validator: (value) =>
                                    value.isEmpty ? "Cannot be empty" : null,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.message),
                                    hintText: "Answers",
                                    labelText: "Answers",
                                    labelStyle: TextStyle(color: Colors.green),
                                    hintStyle: TextStyle(color: Colors.grey)),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.02,
                            top: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: OutlineButton(
                            // color: Colors.green,
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 1.0,
                            ),
                            onPressed: () {
                              validateAndSubmit(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Lets see !!",
                                  style: TextStyle(color: Colors.green),
                                ),
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.green[600],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        // ),
      ),
    );
  }
}

class RevealPage extends StatefulWidget {
  @override
  _RevealPageState createState() => _RevealPageState();
}

class _RevealPageState extends State<RevealPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(
      child: Builder(
        builder: (context) {
          return Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  height: 150,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Let's see what we got!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.4,
                ),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.fiber_manual_record),
                        title: Text("Unlimited Growth"),
                      ),
                      ListTile(
                        leading: Icon(Icons.fiber_manual_record),
                        title: Text("Don’t want to do an MBA"),
                      ),
                      ListTile(
                        leading: Icon(Icons.fiber_manual_record),
                        title: Text("Becoming a Founder or Own Boss"),
                      ),
                      ListTile(
                        leading: Icon(Icons.fiber_manual_record),
                        title: Text("Getting Funded and Famous"),
                      ),
                      ListTile(
                        leading: Icon(Icons.fiber_manual_record),
                        title: Text("Following a Passion"),
                      ),
                      ListTile(
                        leading: Icon(Icons.fiber_manual_record),
                        title: Text("Don’t Like a 9-5 Job"),
                      ),
                      ListTile(
                        leading: Icon(Icons.error_outline),
                        title: Text(
                          "Well, if your answer is close to any of these reasons, think twice!",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: OutlineButton(
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 1.5,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => new VideoPlay(
                                  videoLink: 'assets/videos/2.mp4',
                                  title: "Are you ready?",
                                  btnTitle: "Ready !!",
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Almost there !!",
                                textAlign: TextAlign.center,
                              ),
                              Icon(
                                Icons.navigate_next,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ));
  }
}
