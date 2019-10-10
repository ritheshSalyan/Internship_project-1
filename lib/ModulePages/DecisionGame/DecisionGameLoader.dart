import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'DecisionGame.dart';

class DecisionGameLoading extends StatefulWidget {
  DecisionGameLoading({Key key, this.modNum,this.index}) : super(key: key);
  final int modNum,index;
  @override
  _DecisionGameLoading createState() => _DecisionGameLoading();
}

class _DecisionGameLoading extends State<DecisionGameLoading> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore().then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DecisionGame(
            modNum: widget.modNum,
            order: widget.index,
          ),
        ),
      );
    });
     return Scaffold(
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
    );
  }

  static Future<void> getEventsFromFirestore() async {}
}
