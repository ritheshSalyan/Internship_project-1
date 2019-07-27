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
  summary,
}

class orderManagement  {
  static List<Type> order = [];
  static int currentIndex = 0;
  List<dynamic> arguments = [];
  static void moveNextIndex(BuildContext context, arguments) {
    
    currentIndex++;
    print("Arguments ${arguments}");
    if (currentIndex == order.length) {
           Navigator.of(context).pushReplacement(
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
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => QuizPage(modNum: arguments[0]),
            ),
          );
          break;

        case Type.activity:
          print("activity");
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ActivityLoading(
              modNum: arguments[0],
            ),
          ));
          break;

          case Type.vocabulary:
          print("vocabulary");
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ActivityLoading(
              modNum: arguments[0],
            ),
          ));
          break;

        case Type.decisionGame:
          print("decisionGame");
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => DecisionGameLoading(
                modNum: arguments[0],
              ),
            ),
          );
          break;

        case Type.caseStudy:
          print("caseStudy");
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Loading(
              modNum: arguments[0],
            ),
          ));
          break;

        case Type.video:
          print("video");
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => VideoControllerLoading(
                modNum: arguments[0],
              ),
            ),
          );
          break;

        case Type.overView:
          print("overView");
          break;

        case Type.theory:
          print("theory");
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => TheoryLoading(modNum: arguments[0]),
            ),
          );
          break;

        case Type.summary:
          print("summary");
          break;

        case Type.discussion:
          print("discussion");
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => DiscussionLoading(modNum: arguments[0]),
            ),
          );
          break;

        default:
          print("Default");
      }
    }
  }
}
