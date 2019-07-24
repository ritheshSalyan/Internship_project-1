import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:startupreneur/ModulePages/ModuleVideoPage.dart';

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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => new VideoPlay(
            videoLink: 'assets/videos/2.mp4',
            title: "Are you ready?",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                "Almost there !!",
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
      ),
    );
  }
}
