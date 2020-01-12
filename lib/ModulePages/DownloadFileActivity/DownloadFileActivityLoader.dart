// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:flutter/material.dart';
import 'package:startupreneur/ModulePages/DownloadFileActivity/DownloadFileActivity.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
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
  static fs.Firestore db = fb.firestore();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.modNum, widget.index).then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DownloadFileActivity(
            modNum: widget.modNum,
            order: widget.index,
            file: value[0],
            content: value,
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

  static Future<List<String>> getEventsFromFirestore(
      int modNum, int order) async {
    fs.CollectionReference ref = db.collection('downloadFileActivity');
    fs.QuerySnapshot eventsQuery = await ref
        .where("module", "==", modNum)
        .where("order", "==", order)
        .get();
    // .where("order",isEqualTo: orderManagement.currentIndex).getDocuments();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
    String title;
    List<String> list = [];
    eventsQuery.docs.forEach((document) {
      print("downloadFileActivity " + document.data()['file']);

      title = document.data()["file"];
      list.add(title);
      try {
        list.addAll(convert(document.data()["content"]));
      } catch (e) {}

      // title.add(document["image"].toString());
    });
    return list;
  }

  static List<String> convert(List<dynamic> dlist) {
    List<String> list = new List<String>();

    for (var item in dlist) {
      list.add(item.toString());
      print(item.toString());
    }
    //list.add("assets/Images/think.png");
    return list;
  }
}
