import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'VideoController.dart';

class VideoControllerLoading extends StatefulWidget {
  VideoControllerLoading({Key key, this.modNum,this.index}) : super(key: key);
  final int modNum,index;
  @override
  _VideoControllerLoading createState() => _VideoControllerLoading();
}

class _VideoControllerLoading extends State<VideoControllerLoading> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.modNum,widget.index).then((title) {
      print("Title is " + title.toString());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => VideoPlay(
            index:widget.index,
            videoLink: title[1],
            title: title[0],
            btnTitle: title[2],
            modNum: widget.modNum,
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

  static Future<List<String>> getEventsFromFirestore(int modNum,int index) async {
    fs.Firestore firestore = fb.firestore();
    print("Index in video "+index.toString());
    fs.CollectionReference ref = firestore.collection('videos');
    fs.QuerySnapshot eventsQuery =
        await ref.where("module", "==", modNum)
        .where("order","==", index).get();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
    List<String> title = [];
    eventsQuery.docs.forEach((document) {
      print("videoController " +
          document.data()["content"].toString());

      title = convert(document.data()["content"]);
    });
    return title;
  }
  
  static List<String> convert(List<dynamic> dlist){

    List<String> list = new List<String>();

    for (var item in dlist) {
       list.add(item.toString());
       print(item.toString());
    }
    return list;
  }
}
