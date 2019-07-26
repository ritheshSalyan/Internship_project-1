import 'package:flutter/material.dart';
import '../ModulePages/quiz/quizLoader.dart';
import '../ModulePages/VideoController.dart';
import 'package:startupreneur/ModulePages/ModuleTheory.dart';

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
 static  List<Type> order = [];
  static int currentIndex = 0;
  List<dynamic> arguments = [];
  static void moveNextIndex(BuildContext context,arguments){
    currentIndex++;
    print("Arguments ${arguments}");
    switch(order[currentIndex]){
      case Type.quote:
        print("quote");
        break;


       case Type.quiz:
        print("quiz");
         Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => QuizLoading(modNum: arguments[0]),
            ),
          );
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
        Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => VideoPlay(
                                          videoLink: 'assets/videos/video.mp4',
                                          title: "Here you go!",
                                          btnTitle: "Tap to continue",
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
                                        builder: (context) => videoPlayerPage(
                                            title: "lets start",
                                            modNum:arguments[0]),
                                      ),
                                    );
        break;


       case Type.summary:
        print("summary");
        break;
        
    }

  }
}