import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'TopicHeading.dart';
import '../../ModuleOrderController/Types.dart';

class TopicHeadingLoading extends StatefulWidget {
  TopicHeadingLoading({Key key, this.modNum,this.index}) : super(key: key);
  final int modNum,index;
  @override
  _TopicHeadingLoading createState() => _TopicHeadingLoading();
}

class _TopicHeadingLoading extends State<TopicHeadingLoading> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.modNum).then((title) {
      print("TopicHeading is " + title.toString());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => TopicHeadingPage(
           index:widget.index,
            modNum: widget.modNum,
            title: title[0],
           
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

  static Future<List<String>> getEventsFromFirestore(int modNum) async {
    CollectionReference ref = Firestore.instance.collection('topicHeading');
    QuerySnapshot eventsQuery =
        await ref.where("module", isEqualTo: modNum)
        .where("order",isEqualTo: orderManagement.currentIndex).getDocuments();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
    List<String> title = [];
    eventsQuery.documents.forEach((document) {
      print("TopicHeading " +
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
