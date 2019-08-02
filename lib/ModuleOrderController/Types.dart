import 'package:flutter/material.dart';
import '../ModulePages/quiz/quizLoader.dart';
import '../ModulePages/quiz/quiz_page.dart';
import '../ModulePages/VideoController/VideoController.dart';
import '../ModulePages/VideoController/VideoControllerLoader.dart';
import 'package:startupreneur/ModulePages/ModuleTheory/ModuleTheory.dart';
import 'package:startupreneur/ModulePages/ModuleTheory/ModuleTheoryLoader.dart';
import '../casestudy/CaseStudyEntry.dart';
import '../ModulePages/Activity/ActivityLoader.dart';
import '../ModulePages/Discussion/DiscussionLoader.dart';
import '../ModulePages/DecisionGame/DecisionGameLoader.dart';
import '../ModulePages/Socialize/socialize.dart';
import '../timeline/MainRoadmap.dart';
import '../ModulePages/ModuleVocabulary/ModuleVocabularyLoader.dart';
import '../ModulePages/FileActivity/FileUploadLoader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ModulePages/DecisionGameText/DecisionGameTextLoader.dart';
import '../ModulePages/SummaryPage/SummaryPageLoader.dart';

enum Type {
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
  uploadActivity
}

class orderManagement {
  static List<Type> order = [];
  static List<dynamic> complete = [];
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
        print("complete $complete");
      });
      complete.add(arguments[0]+1);
      var data = Map<String, dynamic>();
      data["completed"] = complete;
      await db.collection("user").document(userid).setData(data, merge: true);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TimelinePage(
            title: "Road Map",
          ),
        ),
      );
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

        default:
          print("Default");
      }
    }
  }
}
