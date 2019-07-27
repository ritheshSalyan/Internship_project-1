import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Discussion.dart';
import '../../ModuleOrderController/Types.dart';

class DiscussionLoading extends StatefulWidget {
  DiscussionLoading({Key key, this.modNum}) : super(key: key);
  final int modNum;
  @override
  _DiscussionLoading createState() => _DiscussionLoading();
}

class _DiscussionLoading extends State<DiscussionLoading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.modNum).then((title) {
      print("Discussion is " + title.toString());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DiscussionPage(
           
            modNum: widget.modNum,
            title: title[0],
            content: title[1],
            button: title[2],
          ),
        ),
      );
    });
    return Scaffold(
      body: CircularProgressIndicator(),
    );
  }

  static Future<List<String>> getEventsFromFirestore(int modNum) async {
    CollectionReference ref = Firestore.instance.collection('discussion');
    QuerySnapshot eventsQuery =
        await ref.where("module", isEqualTo: modNum)
        .where("order",isEqualTo: orderManagement.currentIndex).getDocuments();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
    List<String> title = [];
    eventsQuery.documents.forEach((document) {
      print("Discussion " +
          document.toString());

      title = convert(document["content"]);
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
