import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'quiz_page.dart';
import '../../ModuleOrderController/Types.dart';

class QuizLoading extends StatefulWidget {
  QuizLoading({Key key, this.modNum}) : super(key: key);
  final int modNum;
  @override
  _QuizLoading createState() => _QuizLoading();
}

class _QuizLoading extends State<QuizLoading> {
  @override
  void initState() {
    // TODO: implement initState
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
          ),
        ),
      );
    });
    return Scaffold();
  }

  static Future<void> getEventsFromFirestore() async {}
}
