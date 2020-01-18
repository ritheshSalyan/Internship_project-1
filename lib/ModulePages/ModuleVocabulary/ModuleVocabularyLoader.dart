import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'ModuleVocabulary.dart';

class ModuleVocabularyLoading extends StatefulWidget {
  ModuleVocabularyLoading({Key key, this.modNum, this.index}) : super(key: key);
  final int modNum, index;
  @override
  _ModuleVocabularyLoading createState() => _ModuleVocabularyLoading();
}

class _ModuleVocabularyLoading extends State<ModuleVocabularyLoading> {
  static final List<String> words = [];
  static final List<String> meanings = [];
  static fs.Firestore db = fb.firestore();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getEventsFromFirestore(widget.modNum).then((title) {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => ModuleVocabulary(
    //         index: widget.index,
    //         modNum: widget.modNum,
    //         word: words,
    //         meaning: meanings,
    //       ),
    //     ),
    //   );
    // });
    return FutureBuilder(
        future: getEventsFromFirestore(widget.modNum),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ModuleVocabulary(
              index: widget.index,
              modNum: widget.modNum,
              word: snapshot.data.data(),
              meaning: snapshot.data.data(),
            );
          }
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
        });
  }

  static Future<void> getEventsFromFirestore(int modNum) async {
    print("hello");
    words.clear();
    meanings.clear();
    // CollectionReference ref = Firestore.instance.collection("vocabulary");
    // QuerySnapshot eventsQuery =
    //     await ref.where("module", isEqualTo: modNum)
    //     .where("order",isEqualTo: orderManagement.currentIndex).getDocuments();
    await db
        .collection("vocabulary")
        .where("module", "==", modNum)
        .get()
        .then((document) {
      document.docs.forEach((value) {
        print(value.data()["word"]);
        // words.clear();
        // meanings.clear();
        for (String i in value.data()["word"]) {
          print(i);
          words.add(i);
        }
        for (String i in value.data()["meaning"]) {
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
