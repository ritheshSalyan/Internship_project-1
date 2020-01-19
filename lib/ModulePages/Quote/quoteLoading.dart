import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'quote.dart';

class QuoteLoading extends StatefulWidget {
  QuoteLoading({Key key, this.modNum}) : super(key: key);
  final int modNum;
  @override
  _QuoteLoading createState() => _QuoteLoading();
}

class _QuoteLoading extends State<QuoteLoading> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getEventsFromFirestore(widget.modNum).then((title) {
    //   print("Title is " + title.toString());
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => Quote(modNum: widget.modNum, quote: title),
    //     ),
    //   );
    // });
    return FutureBuilder(
        future: getEventsFromFirestore(widget.modNum),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("data of future from quote ${snapshot.data}");
            return Quote(
              modNum: widget.modNum,
              quote: snapshot.data,
            );
          }
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
        });
  }

  static Future<List<String>> getEventsFromFirestore(int modNum) async {
    fs.Firestore db = fb.firestore();
    fs.CollectionReference ref = db.collection('module');
    fs.QuerySnapshot eventsQuery = await ref.where("id", "==", modNum).get();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
    List<String> title = [];
    eventsQuery.docs.forEach((document) {
      print("Quote " + document.toString());

      for (var item in document.data()["quote"]) {
        title.add(item.toString());
      }
    });
    return title;
  }
}
