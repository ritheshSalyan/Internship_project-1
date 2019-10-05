import 'package:flutter/material.dart';
import 'package:startupreneur/ModulePages/FlipPage/FlipPage.dart';
import 'package:startupreneur/ModulePages/IdeaActivity/IdeaActivity.dart';
import '../ModulePages/quiz/quizLoader.dart';
import '../ModulePages/SummaryPage/ConclusionPage.dart';
import '../ModulePages/VideoController/VideoControllerLoader.dart';
import 'package:startupreneur/ModulePages/ModuleTheory/ModuleTheoryLoader.dart';
import '../casestudy/CaseStudyEntry.dart';
import '../ModulePages/Activity/ActivityLoader.dart';
import '../ModulePages/Discussion/DiscussionLoader.dart';
import '../ModulePages/DecisionGame/DecisionGameLoader.dart';
import '../ModulePages/Socialize/socialize.dart';
import '../ModulePages/ModuleVocabulary/ModuleVocabularyLoader.dart';
import '../ModulePages/FileActivity/FileUploadLoader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ModulePages/DecisionGameText/DecisionGameTextLoader.dart';
import '../ModulePages/SummaryPage/SummaryPageLoader.dart';
import '../ModulePages/TopicHeading/TopicHeadingLoader.dart';
import '../ModulePages/HustelTip/HustelTipLoader.dart';
import '../ModulePages/ImagePage/ImagePageLoader.dart';

enum Type {
  heading,
  quote,
  quiz,
  vocabulary,
  caseStudy,
  overView,
  video,
  theory,
  activity,
  decisionGame,
  discussion,
  socialize,
  summary,
  decisionGameText,
  uploadActivity,
  hustelTip,
  imagePage,
  flip,
  ideaActivity,
}

class orderManagement {
  static List<Type> order = [];
  static List<dynamic> complete = [];
  static dynamic points ;
  static dynamic modulePoint;
  static int currentIndex = 0;
  static String userid = "";
  List<dynamic> arguments = [];
  static Firestore db = Firestore.instance;
  static SharedPreferences sharedPreferences;


  static void moveNextIndex(BuildContext context, arguments) async {
    currentIndex = arguments[1];
    print("Arguments ${arguments}");
    print("currentIndex ${currentIndex}");
    sharedPreferences = await SharedPreferences.getInstance();
    userid = sharedPreferences.getString("UserId");

    if (currentIndex == order.length) {
      await db.collection("user").document(userid).get().then((document) {
        complete = new List<dynamic>.from(document.data["completed"]);
        points = document.data["points"];
        print("complete $complete");
      });
      await db.collection("points").where("module",isEqualTo:arguments[0]).getDocuments().then((document){
        document.documents.forEach((val){
          modulePoint  =  val.data["point"];
        });
      });

      // if((arguments[0] + 1)==1){
      //   var data = Map<String, dynamic>();
      //   data["completed"] = complete;
      //   data["points"] = points+modulePoint;
      //   await db.collection("user").document(userid).setData(data, merge: true);
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => SummaryPage(),
      //     ),
      //   );
      // }
      if (complete.contains(arguments[0] + 1)) {
        print("already there");
         Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SummaryPage(),
          ),
        );
      } else {
        // complete.add(arguments[0] + 1);
        // var data = Map<String, dynamic>();
        // data["completed"] = complete;
        // data["points"] = points+modulePoint;
        // await db.collection("user").document(userid).setData(data, merge: true);
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => SummaryPage(),
        //   ),
        // );
      }
    } else {
      switch (order[currentIndex]) {
        case Type.quote:
          print("quote");
          break;

        case Type.quiz:
          print("quiz");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  QuizLoading(modNum: arguments[0], index: currentIndex),
            ),
          );
          break;

        case Type.imagePage:
          print("imagePage");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  ImagePageLoading(modNum: arguments[0], index: currentIndex),
            ),
          );
          break;
           case Type.ideaActivity:
          print("ideaActivity $currentIndex");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                 IdeaActivity(modNum: arguments[0], index: currentIndex),
            ),
          );
          break;

           case Type.flip:
          print("flip");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                 FlipPage(modnum: arguments[0], index: currentIndex),
            ),
          );
          break;
        case Type.uploadActivity:
          print("activity");
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                FileUploadLoading(modNum: arguments[0], index: currentIndex),
          ));
          break;
        case Type.activity:
          print("activity");
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ActivityLoading(modNum: arguments[0], index: currentIndex),
          ));
          break;

        case Type.socialize:
          print("socialize");
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                SocializeTask(modNum: arguments[0], index: currentIndex),
          ));
          break;

        case Type.vocabulary:
          print("vocabulary");
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ModuleVocabularyLoading(
                modNum: arguments[0], index: currentIndex),
          ));
          break;

        case Type.hustelTip:
          print("hustelTip");
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                HustelTipLoading(modNum: arguments[0], index: currentIndex),
          ));
          break;

        case Type.decisionGame:
          print("decisionGame");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DecisionGameLoading(
                  modNum: arguments[0], index: currentIndex),
            ),
          );
          break;
        case Type.decisionGameText:
          print("decisionGameText");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DecisionGameTextLoading(
                  modNum: arguments[0], index: currentIndex),
            ),
          );
          break;
        case Type.caseStudy:
          print("caseStudy");
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                Loading(modNum: arguments[0], index: currentIndex),
          ));
          break;

        case Type.video:
          print("video");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VideoControllerLoading(
                  modNum: arguments[0], index: currentIndex),
            ),
          );
          break;

        case Type.overView:
          print("overView");
          break;

        case Type.theory:
          print("theory");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  TheoryLoading(modNum: arguments[0], index: currentIndex),
            ),
          );
          break;

        case Type.summary:
          print("summary");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  SummaryPageLoader(modNum: arguments[0], index: currentIndex),
            ),
          );
          break;

        case Type.discussion:
          print("discussion");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  DiscussionLoading(modNum: arguments[0], index: currentIndex),
            ),
          );
          break;
        case Type.heading:
          print("heading");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TopicHeadingLoading(
                  modNum: arguments[0], index: currentIndex),
            ),
          );
          break;
        default:
          print("Default");
      }
    }
  }
}
