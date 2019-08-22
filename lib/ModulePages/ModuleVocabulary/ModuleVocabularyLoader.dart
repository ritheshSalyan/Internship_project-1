import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ModuleVocabulary.dart';
import '../../ModuleOrderController/Types.dart';

class ModuleVocabularyLoading extends StatefulWidget {
  ModuleVocabularyLoading({Key key, this.modNum, this.index}) : super(key: key);
  final int modNum, index;
  @override
  _ModuleVocabularyLoading createState() => _ModuleVocabularyLoading();
}

class _ModuleVocabularyLoading extends State<ModuleVocabularyLoading> {
  static final List<String> words = [];
  static final List<String> meanings = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.modNum).then((title) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ModuleVocabulary(
            index: widget.index,
            modNum: widget.modNum,
            word: words,
            meaning: meanings,
          ),
        ),
      );
    });
    return Scaffold(
      body: CircularProgressIndicator(),
    );
  }

  static Future<void> getEventsFromFirestore(int modNum) async {
    print("hello");
    words.clear();
    meanings.clear();
    // CollectionReference ref = Firestore.instance.collection("vocabulary");
    // QuerySnapshot eventsQuery =
    //     await ref.where("module", isEqualTo: modNum)
    //     .where("order",isEqualTo: orderManagement.currentIndex).getDocuments();
    await Firestore.instance
        .collection("vocabulary")
        .where("module", isEqualTo: modNum)
        .getDocuments()
        .then((document) {
      document.documents.forEach((value) {
        print(value["word"]);
        // words.clear();
        // meanings.clear();
        for (String i in value["word"]) {
          print(i);
          words.add(i);
        }
        for (String i in value["meaning"]) {
          meanings.add(i);
        }
      });
    });
    // print();
//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
    // List<String> title = [];
    // eventsQuery.documents.forEach((document) {
    //   print("vocabulary " +
    //       document.toString());

    //   title = convert(document["word"]);
    // });
    // return title;
  }

  // static List<String> convert(List<dynamic> dlist){

  //   List<String> list = new List<String>();

  //   for (var item in dlist) {
  //      list.add(item.toString());
  //      print(item.toString());
  //   }
  //   return list;
  // }
}
