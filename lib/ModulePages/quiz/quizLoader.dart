import 'package:flutter/material.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'quiz_page.dart';
import '../../ModuleOrderController/Types.dart';

class QuizLoading extends StatefulWidget {
  QuizLoading({Key key, this.modNum,this.index}) : super(key: key);
  final int modNum,index;
  @override
  _QuizLoading createState() => _QuizLoading();
}

class _QuizLoading extends State<QuizLoading> {
  @override
  void initState() {

    super.initState();
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => QuizPage(modNum: widget.modNum),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore().then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => QuizPage(
            modNum: widget.modNum,
            order: orderManagement.currentIndex,
            index:widget.index+1,
          ),
        ),
      );
    });
     return CustomeOffline(
            onConnetivity: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new CircularProgressIndicator(
                strokeWidth: 5,
                value: null,
                valueColor: new AlwaysStoppedAnimation(Colors.green),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                color: Colors.transparent,
                child: Text(
                  "Loading... Please Wait",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
    ),
     );
  }

  static Future<void> getEventsFromFirestore() async {}
}
