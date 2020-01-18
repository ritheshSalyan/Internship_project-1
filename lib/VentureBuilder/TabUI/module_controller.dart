import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:startupreneur/ModuleOrderController/Types.dart';
import 'package:startupreneur/ModulePages/Activity/ActivityLoader.dart';
import 'package:startupreneur/ModulePages/DecisionGame/DecisionGameLoader.dart';
import 'package:startupreneur/ModulePages/DecisionGameText/DecisionGameTextLoader.dart';
import 'package:startupreneur/ModulePages/Discussion/DiscussionLoader.dart';
import 'package:startupreneur/ModulePages/FileActivity/FileUploadLoader.dart';
import 'package:startupreneur/ModulePages/FlipPage/FlipPage.dart';
import 'package:startupreneur/ModulePages/HustelTip/HustelTipLoader.dart';
import 'package:startupreneur/ModulePages/IdeaActivity/IdeaActivity.dart';
import 'package:startupreneur/ModulePages/ImagePage/ImagePageLoader.dart';
import 'package:startupreneur/ModulePages/ModuleOverview/ModuleOverviewLoading.dart';
import 'package:startupreneur/ModulePages/ModuleTheory/ModuleTheoryLoader.dart';
import 'package:startupreneur/ModulePages/ModuleVocabulary/ModuleVocabularyLoader.dart';
import 'package:startupreneur/ModulePages/SummaryPage/SummaryPageLoader.dart';
import 'package:startupreneur/ModulePages/TopicHeading/TopicHeadingLoader.dart';
import 'package:startupreneur/ModulePages/VideoController/VideoControllerLoader.dart';
import 'package:startupreneur/ModulePages/quiz/quizLoader.dart';
import 'package:startupreneur/casestudy/CaseStudyEntry.dart';
import 'package:startupreneur/saveProgress.dart';

class ModuleTraverse with ChangeNotifier {
  int modnum, order;
  static List<Type> modOrder = [];

  ModuleTraverse({int modnum = 2, int order = 0}) {
    print(
        "ModuleTraverse modnum is  =============================================================================================================================== $modnum");
    SaveProgress.getEventsFromFirestore(modnum);
    this.modnum = modnum;
    this.order = order;
  }

  void updateModNum(int modNum) {
    print("Inside updateModule $modNum $modnum");
    if (this.modnum != modNum) {
      modnum = modNum;
      print(
          "ModuleTraverse modnum is  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; $modnum");
      SaveProgress.getEventsFromFirestore(modnum);
      this.modnum = modnum;
      this.order = order;
      notifyListeners();
    }
  }

  void navigate() {
    order++;
    print("navigate $order $modnum");
    notifyListeners();
  }

  Widget nextPage() {
    // order++;
    print("nextPage $order $modnum");
    switch (modOrder[order]) {
      // case Type.quote:
      //   print("quote");
      //   break;

      case Type.quiz:
        print("quiz");
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        // builder: (context) =>
        return QuizLoading(modNum: modnum, index: order);
        //   ),
        // );
        break;
      case Type.download:
        //   print("Download");
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => DownloadFileActivityLoader(
        //           modNum: arguments[0], index: currentIndex),
        //     ),
        //   );
        break;
      case Type.imagePage:
        print("imagePage");
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) =>
        return ImagePageLoading(modNum: modnum, index: order);
        //   ),
        // );
        break;
      case Type.ideaActivity:
        // print("ideaActivity $currentIndex");
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) =>
        return IdeaActivity(modNum: modnum, index: order);
        //   ),
        // );
        break;

      case Type.flip:
        print("flip");
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) =>
        return FlipPage(modnum: modnum, index: order);
        //   ),
        // );
        break;
      case Type.uploadActivity:
        print("activity");
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) =>
        return FileUploadLoading(modNum: modnum, index: order);
        // ));
        break;
      case Type.activity:
        print("activity");
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) =>
        return ActivityLoading(modNum: modnum, index: order);
        // ));
        break;

      // case Type.socialize:
      //   print("socialize");
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) =>
      //         SocializeTask(modNum: arguments[0], index: currentIndex),
      //   ));
      //   break;

      case Type.vocabulary:
        print("vocabulary");
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) =>
        return ModuleVocabularyLoading(modNum: modnum, index: order);
        // ));
        break;

      case Type.hustelTip:
        print("hustelTip");
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) =>
        return HustelTipLoading(modNum: modnum, index: order);
        // ));
        break;

      case Type.decisionGame:
        print("decisionGame");
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) =>
        return DecisionGameLoading(modNum: modnum, index: order);
        //   ),
        // );
        break;
      case Type.decisionGameText:
        print("decisionGameText");
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) =>
        return DecisionGameTextLoading(modNum: modnum, index: order);
        //   ),
        // );
        break;
      case Type.caseStudy:
        print("caseStudy");
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) =>
        return Loading(modNum: modnum, index: order);
        // ));
        break;

      case Type.video:
        print("video");
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) =>
        return VideoControllerLoading(modNum: modnum, index: order);
        //   ),
        // );
        break;

      case Type.overView:
        print("overView");
        return ModuleOverviewLoading(
          modNum: modnum,
        );
        break;

      case Type.theory:
        print("theory");
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) =>
        return TheoryLoading(modNum: modnum, index: order);
        //   ),
        // );
        break;

      case Type.summary:
        print("summary");
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) =>
        return SummaryPageLoader(modNum: modnum, index: order);
        //   ),
        // );
        break;

      case Type.discussion:
        print("discussion");
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) =>
        return DiscussionLoading(modNum: modnum, index: order);
        //   ),
        // );
        break;
      case Type.heading:
        print("heading");
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) =>
        return TopicHeadingLoading(modNum: modnum, index: order);
        //   ),
        // );
        break;
      default:
        print("Default");
    }
  }
}
