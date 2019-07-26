import 'package:flutter/material.dart';

enum Type{
  quote,
  quiz,
  caseStudy,
  overView,
  video,
  theory,
  activity,
  decisionGame,
  summary,
}

class orderManagement{
  List<Type> order = [];
  int currentIndex = 0;
  List<dynamic> arguments = [];
  void moveNextIndex(BuildContext context,arguments){
    currentIndex++;
    switch(order[currentIndex]){
      case Type.quote:
        print("quote");
        break;
       case Type.quiz:
        print("quiz");
        break;
       case Type.activity:
        print("activity");
        break;
       case Type.decisionGame:
        print("decisionGame");
        break;
       case Type.caseStudy:
        print("caseStudy");
        break;
       case Type.video:
        print("video");
        break;
       case Type.overView:
        print("overView");
        break;
        case Type.theory:
        print("theory");
        break;
       case Type.summary:
        print("summary");
        break;
    }

  }
}