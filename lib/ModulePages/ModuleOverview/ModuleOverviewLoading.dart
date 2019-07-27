import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ModuleOverview.dart';
import '../../ModuleOrderController/Types.dart';

class ModuleOverviewLoading extends StatefulWidget {
  ModuleOverviewLoading({Key key, this.modNum}) : super(key: key);
  final int modNum;
  @override
  _ModuleOverviewLoading createState() => _ModuleOverviewLoading();
}

class _ModuleOverviewLoading extends State<ModuleOverviewLoading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.modNum).then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ModulePageIntro(
            modNum: widget.modNum,
            index : 0,
          ),
        ),
      );
    });
    return Scaffold();
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

                          print("orderManagement.order "+orderManagement.order.toString());
                      //  }

     
});

    // QuerySnapshot snapshot = await ref.
    
  }

   static List<Type> convert(List<dynamic> list ){
    List<Type> typeList = [];
      for (var item in list) {
      switch(item){
      case "Type.quote":
        print("quote");
        typeList.add(Type.quote);
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


       case "Type.summary":
       typeList.add(Type.summary);
        print("summary");
        break;

        case "Type.discussion":
         typeList.add(Type.discussion);
        print("summary");
        break;

        default:
            print("Default");

        
    }
      }
      return typeList;

  }
}
