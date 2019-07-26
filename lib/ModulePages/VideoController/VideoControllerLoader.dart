import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'VideoController.dart';
import '../../ModuleOrderController/Types.dart';

class VideoControllerLoading extends StatefulWidget {
  VideoControllerLoading({Key key, this.modNum}) : super(key: key);
  final int modNum;
  @override
  _VideoControllerLoading createState() => _VideoControllerLoading();
}

class _VideoControllerLoading extends State<VideoControllerLoading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.modNum).then((title) {
      print("Title is " + title.toString());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => VideoPlay(
            videoLink: title[1],
            title: title[0],
            btnTitle: title[2],
            modNum: widget.modNum,
          ),
        ),
      );
    });
    return Scaffold();
  }

  static Future<List<String>> getEventsFromFirestore(int modNum) async {
    CollectionReference ref = Firestore.instance.collection('module');
    QuerySnapshot eventsQuery =
        await ref.where("id", isEqualTo: modNum).getDocuments();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
    List<String> title = [];
    eventsQuery.documents.forEach((document) {
      print("videoController " +
          document["order${orderManagement.currentIndex}"].toString());

      title = convert(document["order${orderManagement.currentIndex}"]);
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
