import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:startupreneur/ModulePages/DownloadFileActivity/DownloadFileActivity.dart';
import '../../ModuleOrderController/Types.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'DecisionGame.dart';

class DownloadFileActivityLoader extends StatefulWidget {
  DownloadFileActivityLoader({Key key, this.modNum, this.index})
      : super(key: key);
  final int modNum, index;
  @override
  _DownloadFileActivityLoader createState() => _DownloadFileActivityLoader();
}

class _DownloadFileActivityLoader extends State<DownloadFileActivityLoader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.modNum).then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DownloadFileActivity(
            modNum: widget.modNum,
            order: widget.index,
            file: value,
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
                "Loading... Please Wait !",
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

  static Future<String> getEventsFromFirestore(int modNum) async {
    CollectionReference ref = Firestore.instance.collection('downloadFileActivity');
    QuerySnapshot eventsQuery =
        await ref.where("module", isEqualTo: modNum)
        .where("order",isEqualTo: 1).getDocuments();
        // .where("order",isEqualTo: orderManagement.currentIndex).getDocuments();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
    String title;
    eventsQuery.documents.forEach((document) {
      print("downloadFileActivity " +
          document['file']);

      title = document["file"];
      // title.add(document["image"].toString());
    });
    return title;
  }
}
