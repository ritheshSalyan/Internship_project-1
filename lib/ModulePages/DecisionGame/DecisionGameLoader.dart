import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'DecisionGame.dart';
import '../../ModuleOrderController/Types.dart';

class DecisionGameLoading extends StatefulWidget {
  DecisionGameLoading({Key key, this.modNum}) : super(key: key);
  final int modNum;
  @override
  _DecisionGameLoading createState() => _DecisionGameLoading();
}

class _DecisionGameLoading extends State<DecisionGameLoading> {
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
          builder: (context) => DecisionGame(
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
