
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class quiz {
  String question = "";
  List<String> option = null;
  quiz({
    @required this.question,
    @required this.option,
  });
}

class FirebaseFetch {
    static Future<List<quiz>> getEventsFromFirestore() async {
CollectionReference ref = Firestore.instance.collection('quiz');
QuerySnapshot eventsQuery = await ref
    .where("module", isEqualTo: 1)
    .getDocuments();

 List<quiz> module = new List<quiz>();
//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();

eventsQuery.documents.forEach((document) {
  print(document["question" ].toString());

  List<dynamic> list = convert(document["question"]);

 for (var i = 0; i < list.length; i++) {
 

  quiz current = new quiz(
          question: list[i],
          option: convert(document["$i"])
      );
   print("the headding is "+current.question);

   module.add(current);
 }
     
});

print(module[0].option[0]);
 return module;
}

  static List<String> convert(List<dynamic> dlist){

    List<String> list = new List<String>();

    for (var item in dlist) {
       list.add(item.toString());
    }
    return list;
  }

  
}