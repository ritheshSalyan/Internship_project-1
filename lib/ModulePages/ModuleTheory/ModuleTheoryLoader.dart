import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ModuleTheory.dart';
import '../../ModuleOrderController/Types.dart';

class TheoryLoading extends StatefulWidget {
  TheoryLoading({Key key, this.modNum}) : super(key: key);
  final int modNum;
  @override
  _TheoryLoading createState() => _TheoryLoading();
}

class _TheoryLoading extends State<TheoryLoading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.modNum).then((title){
      print("Title is "+title);
         Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => videoPlayerPage(modNum: widget.modNum,title: title),
      ),
    );

    });
    return Scaffold();
  }

  static Future<String> getEventsFromFirestore(int modNum) async {
      CollectionReference ref = Firestore.instance.collection('module');
QuerySnapshot eventsQuery = await ref
    .where("id", isEqualTo: modNum)
    .getDocuments();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
String title = "hello";
eventsQuery.documents.forEach((document) {
  print("title "+document["order${orderManagement.currentIndex}" ].toString());

  title = document["order${orderManagement.currentIndex}" ].toString();
});
  return title;
  }
}
