import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'ModuleTheory.dart';
import '../../ModuleOrderController/Types.dart';

class TheoryLoading extends StatefulWidget {
  TheoryLoading({Key key, this.modNum, this.index}) : super(key: key);
  final int modNum, index;
  @override
  _TheoryLoading createState() => _TheoryLoading();
}

class _TheoryLoading extends State<TheoryLoading> {
  static fs.Firestore db = fb.firestore();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.modNum).then((title) {
      print("Title is " + title);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => videoPlayerPage(
            modNum: widget.modNum,
            title: title,
            index: widget.index,
          ),
        ),
      );
    });
    return CustomeOffline(
      onConnetivity: Scaffold(
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "${widget.index + 1}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
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

  static Future<String> getEventsFromFirestore(int modNum) async {
    fs.CollectionReference ref = db.collection('module');
    fs.QuerySnapshot eventsQuery = await ref.where("id", "==", modNum).get();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
    String title = "hello";
    eventsQuery.docs.forEach((document) {
      print("title " +
          document.data()["order${orderManagement.currentIndex}"].toString());

      title =
          document.data()["order${orderManagement.currentIndex}"].toString();
    });
    return title;
  }
}
