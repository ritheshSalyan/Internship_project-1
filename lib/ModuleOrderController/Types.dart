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
}

class orderManagement  {
  static List<Type> order = [];
  static int currentIndex = 0;
  List<dynamic> arguments = [];
  static void moveNextIndex(BuildContext context, arguments) {
    
    currentIndex = arguments[1];
    print("Arguments ${arguments}");
    print("currentIndex ${currentIndex}");
    if (currentIndex == order.length) {
           Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TimelinePage(title: "Road Map",),
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
              builder: (context) => QuizLoading(modNum: arguments[0],index:currentIndex),
            ),
          );
          break;

        case Type.activity:
          print("activity");
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ActivityLoading(
              modNum: arguments[0],
              index:currentIndex
            ),
          ));
          break;

          case Type.socialize:
          print("socialize");
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SocializeTask(
              modNum: arguments[0],
              index:currentIndex
            ),
          ));
          break;

          case Type.vocabulary:
          print("vocabulary");
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ActivityLoading(
              modNum: arguments[0],
              index:currentIndex
            ),
          ));
          break;

        case Type.decisionGame:
          print("decisionGame");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DecisionGameLoading(
                modNum: arguments[0],
                index:currentIndex
              ),
            ),
          );
          break;

        case Type.caseStudy:
          print("caseStudy");
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Loading(
              modNum: arguments[0],
              index:currentIndex
            ),
          ));
          break;

        case Type.video:
          print("video");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VideoControllerLoading(
                modNum: arguments[0],
                index:currentIndex
              ),
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
              builder: (context) => TheoryLoading(modNum: arguments[0],index:currentIndex),
            ),
          );
          break;

        case Type.summary:
          print("summary");
          break;

        case Type.discussion:
          print("discussion");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DiscussionLoading(modNum: arguments[0],index:currentIndex),
            ),
          );
          break;

        default:
          print("Default");
      }
    }
  }
}