import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'SummaryPage.dart';


class SummaryPageLoader extends StatefulWidget {
  SummaryPageLoader({Key key,this.modNum , this.index}):super(key:key);
  final int modNum,index;
  @override
  _SummaryPageLoaderState createState() => _SummaryPageLoaderState();
}

class _SummaryPageLoaderState extends State<SummaryPageLoader> {
  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.modNum).then((title) {
      print("Discussion is " + title.toString());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SummaryTheoryPage(
            index:widget.index,
            modNum: widget.modNum,
            title: title[0],
            content: title[1],
            button: title[2],
            image: title[3],
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

  static Future<List<String>> getEventsFromFirestore(int modNum) async {
    CollectionReference ref = Firestore.instance.collection('summary');
    QuerySnapshot eventsQuery =
    await ref.where("module", isEqualTo: modNum)
       .getDocuments();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
    List<String> title = [];
    eventsQuery.documents.forEach((document) {
      print("Discussion " +
          document.toString());

      title = convert(document["content"]);
      title.add(document["image"].toString());
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
