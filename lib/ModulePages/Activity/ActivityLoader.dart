import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Activity.dart';
import '../../ModuleOrderController/Types.dart';

class ActivityLoading extends StatefulWidget {
  ActivityLoading({Key key, this.modNum,this.index}) : super(key: key);
  int modNum,index;
  @override
  _ActivityLoading createState() => _ActivityLoading();
}

class _ActivityLoading extends State<ActivityLoading> {
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
          builder: (context) => ActivityPage( 
            modNum: widget.modNum,
            question: title[0],
              buttonTitle: title[1],
              hint: title[2],
            index:widget.index+1
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

  static Future<List<String>> getEventsFromFirestore(int modNum) async {
    CollectionReference ref = Firestore.instance.collection('module');
    QuerySnapshot eventsQuery =
        await ref.where("id", isEqualTo: modNum).getDocuments();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
    List<String> title = [];
    eventsQuery.documents.forEach((document) {
      print("Activity " +
         modNum.toString());

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
