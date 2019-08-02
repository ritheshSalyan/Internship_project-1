import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DecisionGameText.dart';
import '../../ModuleOrderController/Types.dart';

class DecisionGameTextLoading extends StatefulWidget {
  DecisionGameTextLoading({Key key, this.modNum,this.index}) : super(key: key);
  final int modNum,index;
  @override
  _DecisionGameTextLoading createState() => _DecisionGameTextLoading();
}

class _DecisionGameTextLoading extends State<DecisionGameTextLoading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.modNum).then((title) {
      print("DecisionGameText is " + title.toString());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DecisionGameTextPage(
           index:widget.index,
            modNum: widget.modNum,
            title: title[0],
            content: title[1],
            button: "Next",
            // button: title[2],
            // image: title[3],
          ),
        ),
      );
    });
    return Scaffold(
      body: CircularProgressIndicator(),
    );
  }

  static Future<List<String>> getEventsFromFirestore(int modNum) async {
    CollectionReference ref = Firestore.instance.collection('decisionGameText');
    QuerySnapshot eventsQuery =
        await ref.where("module", isEqualTo: modNum)
        .where("order",isEqualTo: orderManagement.currentIndex).getDocuments();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
    List<String> title = [];
    eventsQuery.documents.forEach((document) {
      print("DecisionGameText " +
          document.toString());

      title = convert(document["content"]);
      // title.add(document["image"].toString());
    });

    return title;
  }
  
  static List<String> convert(List<dynamic> dlist){

    List<String> list = new List<String>();

    for (var item in dlist) {
       list.add(item.toString());
       print(item.toString());
    }
    //list.add("assets/Images/think.png");
    return list;
  }
}
