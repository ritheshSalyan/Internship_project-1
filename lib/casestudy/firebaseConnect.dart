// import 'package:cloud_firestore/cloud_firestore.dart';
import '../ModuleOrderController/Types.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart';

class FirebaseFetch {
  static fs.Firestore firestore = fb.firestore();
  static Future<List<String>> getEventsFromFirestore(int modNum) async {
    var ref = firestore.collection('story');
    var eventsQuery = await ref
        .where("module","==", modNum)
        .where("order", "==", orderManagement.currentIndex)
        .get();

    List<String> module = new List<String>();
//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();

    eventsQuery.docs.forEach((document) {
      // print(document.data()["dialogue"].toString());

      List<String> module1 = convert(document.data()["dialogue"]);

      module = singleLine(module1);
    });

    return module;
  }

  static List<String> convert(List<dynamic> dlist) {
    List<String> list = new List<String>();

    for (var item in dlist) {
      list.add(item.toString());
      //  print(item.toString());
    }
    return list;
  }

  static List<String> singleLine(List<String> dlist) {
    List<String> single = [];

    for (String item in dlist) {
      // print("singleLine ==>"+item);
      for (var i in item.split(". ")) {
        //  print("singleLine i ==>"+i);
        if (i.isNotEmpty || i == " ") {
          single.add(i);
        }
      }
    }
    return single;
  }
}
