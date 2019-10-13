
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ModuleOrderController/Types.dart';

class FirebaseFetch {

    static Future<List<String>> getEventsFromFirestore(int modNum) async {
CollectionReference ref = Firestore.instance.collection('story');
QuerySnapshot eventsQuery = await ref
    .where("module", isEqualTo: modNum)
    .where("order",isEqualTo: orderManagement.currentIndex)
    .getDocuments();

 List<String> module = new List<String>();
//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();

eventsQuery.documents.forEach((document) {
  print(document["dialogue" ].toString());

  List<String>module1 = convert(document["dialogue" ]);

    module = singleLine(module1);
});


 return module;
}

  static List<String> convert(List<dynamic> dlist){

    List<String> list = new List<String>();

    for (var item in dlist) {
       list.add(item.toString());
      //  print(item.toString());
    }
    return list;
  }
  
  static List<String> singleLine(List<String> dlist){

      List<String> single = [];

      for(String item in dlist){
        // print("singleLine ==>"+item);
        for (var i in item.split(". ")) {
          //  print("singleLine i ==>"+i);
           if(i.isNotEmpty || i == " "){
           single.add(i);
           }

        }
      }
      return single;

  }

  
}