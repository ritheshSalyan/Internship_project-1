import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ModuleOrderController/Types.dart';

class SaveProgress {
  static preferences(int modNum, int index) async {
    print("SaveProgress:Inside");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("$modNum", index);
    // sharedPreferences.setInt("${index}", index);
    print(sharedPreferences.getInt("$modNum"));
  }

  static Future<int> getProgerss(int modNum) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      int index = sharedPreferences.getInt("$modNum");
      print("INDEX" + index.toString());
      if (index.toString() == "null") {
        return 0;
      } else {
        return index;
      }
    } catch (e) {
      return 0;
    }
  }

  static List<Type> convert(List<dynamic> list) {
    List<Type> typeList = [];
    for (var item in list) {
      switch (item) {
        case "Type.quote":
          print("quote");
          typeList.add(Type.quote);
          break;
        case "Type.imagePage":
          print("imagePage");
          typeList.add(Type.imagePage);
          break;
        case "Type.vocabulary":
          print("vocabulary");
          typeList.add(Type.vocabulary);
          break;

        case "Type.quiz":
          print("quiz");
          typeList.add(Type.quiz);
          break;

        case "Type.activity":
          print("activity");
          typeList.add(Type.activity);
          break;

        case "Type.decisionGame":
          print("decisionGame");
          typeList.add(Type.decisionGame);
          break;

        case "Type.uploadActivity":
          print("decisionGame");
          typeList.add(Type.uploadActivity);
          break;

        case "Type.socialize":
          print("socialize");
          typeList.add(Type.socialize);
          break;

        case "Type.caseStudy":
          print("caseStudy");
          typeList.add(Type.caseStudy);
          break;

        case "Type.video":
          print("video");
          typeList.add(Type.video);
          break;

        case "Type.overView":
          print("overView");
          typeList.add(Type.overView);
          break;

        case "Type.theory":
          print("theory");
          typeList.add(Type.theory);
          break;
        case "Type.hustelTip":
          print("theory");
          typeList.add(Type.hustelTip);
          break;
        case "Type.summary":
          typeList.add(Type.summary);
          print("summary");
          break;

        case "Type.decisionGameText":
          typeList.add(Type.decisionGameText);
          print("decisionGameText");
          break;

        case "Type.discussion":
          typeList.add(Type.discussion);
          print("discussion");
          break;
        case "Type.heading":
          print("heading");
          typeList.add(Type.heading);
          break;

        case "Type.flip":
          print("flip");
          typeList.add(Type.flip);
          break;

          
          case "Type.ideaActivity":
          print("Type.ideaActivity");
          typeList.add(Type.ideaActivity);
          break;
        default:
          print("Default");
      }
    }
    return typeList;
  }

  static Future<void> getEventsFromFirestore(int modNum) async {
    CollectionReference ref = Firestore.instance.collection('module');
    QuerySnapshot eventsQuery = await ref
        .where("id", isEqualTo: modNum)
        // .where("order",isEqualTo: orderManagement.currentIndex)
        .getDocuments();

    eventsQuery.documents.forEach((document) {
      //if(orderManagement.order.isEmpty){
      orderManagement.order = convert(document.data["order"]);

      print("orderManagement.order " + orderManagement.order.toString());
      //  }
    });
  }
}
