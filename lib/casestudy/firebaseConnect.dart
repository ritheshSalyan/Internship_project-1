
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFetch {

    static Future<List<String>> getEventsFromFirestore(int modNum) async {
CollectionReference ref = Firestore.instance.collection('story');
QuerySnapshot eventsQuery = await ref
    .where("module", isEqualTo: modNum)
    .getDocuments();

 List<String> module = new List<String>();
//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();

eventsQuery.documents.forEach((document) {
  print(document["dialogue" ].toString());

  module = convert(document["dialogue" ]);

     
});


 return module;
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