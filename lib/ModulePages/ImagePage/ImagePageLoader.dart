import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ImagePage.dart';
import '../../ModuleOrderController/Types.dart';

class ImagePageLoading extends StatefulWidget {
  ImagePageLoading({Key key, this.modNum,this.index}) : super(key: key);
  final int modNum,index;
  @override
  _ImagePageLoading createState() => _ImagePageLoading();
}

class _ImagePageLoading extends State<ImagePageLoading> {
  @override
  void initState() {
    // TODO: implement initState
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
    return Scaffold(
      body: CircularProgressIndicator(),
    );
  }

  static Future<List<String>> getEventsFromFirestore(int modNum,int index) async {
    CollectionReference ref = Firestore.instance.collection('ImagePage');
    QuerySnapshot eventsQuery =
        await ref.where("module", isEqualTo: modNum)
        .where("order",isEqualTo: index).getDocuments();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
    List<String> title = [];
    eventsQuery.documents.forEach((document) {
      print("ImagePage " +
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