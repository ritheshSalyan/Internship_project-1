import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'ImagePage.dart';

class ImagePageLoading extends StatefulWidget {
  ImagePageLoading({Key key, this.modNum,this.index}) : super(key: key);
  final int modNum,index;
  @override
  _ImagePageLoading createState() => _ImagePageLoading();
}

class _ImagePageLoading extends State<ImagePageLoading> {
  static fs.Firestore db =fb.firestore();
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.modNum,widget.index).then((title) {
      print("ImagePage is " + title.toString());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ImagePagePage(
           index:widget.index,
            modNum: widget.modNum,
            title: title[0],
            headding:title[1],
           
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
    fs.CollectionReference ref = db.collection('ImagePage');
    fs.QuerySnapshot eventsQuery =
        await ref.where("module", "==", modNum)
        .where("order","==", index).get();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
    List<String> title = [];
    eventsQuery.docs.forEach((document) {
      print("ImagePage " +
          document.toString());

      title = convert(document.data()["content"]);
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
