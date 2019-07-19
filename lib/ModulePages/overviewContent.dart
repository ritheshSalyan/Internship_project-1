
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class overview {
  String headding = "";
  List<String> content = null;
  overview({
    @required this.headding,
    @required this.content,
  });




}

class FirebaseFetch {

    static Future<List<overview>> getEventsFromFirestore(int modNum) async {
CollectionReference ref = Firestore.instance.collection('module');
QuerySnapshot eventsQuery = await ref
    .where("id", isEqualTo: 1)
    .getDocuments();

 List<overview> module = new List<overview>();
//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();

eventsQuery.documents.forEach((document) {
  print(document["overview" ].toString());

  List<String> list = convert(document["overview" ]);

 for (var i = 0; i < list.length; i++) {
 

  overview current = new overview(
          headding: list[i],
          content: convert(document["$i"])
      );
   print("the headding is "+current.headding);

   module.add(current);
 }
     
});

print(module[0].content[0]);
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