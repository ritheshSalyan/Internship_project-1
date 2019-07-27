import 'package:flutter/material.dart';
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
    // TODO: implement initState
    super.initState();
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
    return Scaffold();
  }

  static Future<void> getEventsFromFirestore() async {}
}
