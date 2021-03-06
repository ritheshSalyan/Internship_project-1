import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'DecisionGameText.dart';
import '../../ModuleOrderController/Types.dart';

class DecisionGameTextLoading extends StatefulWidget {
  DecisionGameTextLoading({Key key, this.modNum,this.index}) : super(key: key);
  final int modNum,index;
  @override
  _DecisionGameTextLoading createState() => _DecisionGameTextLoading();
}

class _DecisionGameTextLoading extends State<DecisionGameTextLoading> {
  static String documentId;
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.modNum,widget.index).then((title) {
      print("DecisionGameText is " + title.toString());
     if(title.isNotEmpty){
        Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DecisionGameTextPage(
           index:widget.index,
            modNum: widget.modNum,
            title: title.isNotEmpty?title[0]:" ",
            content:  title.isNotEmpty?title[1]:" ",
            button: "Next",
            id:documentId,
            // button: title[2],
            // image: title[3],
          ),
        ),
      );
     }
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
    CollectionReference ref = Firestore.instance.collection('decisionGameText');
    QuerySnapshot eventsQuery =
        await ref.where("module", isEqualTo: modNum)
        .where("order",isEqualTo: index).getDocuments();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
    List<String> title = [];
   eventsQuery.documents.forEach((document)  {
      print("DecisionGameText " +
          document.toString());
          documentId = document.documentID;

      title.addAll(convert(document["content"]));
     
      // title.add(document["image"].toString());
    });
    print("Title in Decisitin game *********************************************************  "+title.toString());
     return title;
    // if(title.isNotEmpty){
      
    // }
    
  }
  
  static List<String> convert(List<dynamic> dlist)  {

    List<String> list = new List<String>();

    for (var item in dlist) {
       list.add(item.toString());
       print(item.toString());
    }
    //list.add("assets/Images/think.png");
    return list;
  }
}
