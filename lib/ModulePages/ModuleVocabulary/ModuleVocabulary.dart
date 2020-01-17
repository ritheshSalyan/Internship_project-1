import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:startupreneur/globalKeys.dart';
import '../../ModuleOrderController/Types.dart';

class ModuleVocabulary extends StatefulWidget {
  ModuleVocabulary({Key key, this.modNum, this.index, this.meaning, this.word})
      : super(key: key);
  int modNum;
  int index;
  final List<String> word;
  final List<String> meaning;
  @override
  _ModuleVocabularyState createState() => _ModuleVocabularyState();
}

class _ModuleVocabularyState extends State<ModuleVocabulary> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  PageController controller;
  fs.Firestore db = fb.firestore();

  @override
  void initState() {
    super.initState();
    controller = PageController();
    // widget.modNum ;
    print("init inisde ${widget.word}");

    Analytics.analyticsBehaviour("Module_Vocabulary_Page", "Vocabulary");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Widget> generate(List word , List meaning) {
    List<Widget> val = [];
    int numb = widget.word.length;
    print("from vocabulary $numb");
    val.add(
      Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.green,
          child: SizedBox(
            width: 250.0,
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Image.asset(
                  "assets/Images/vocabulary.png",
                  height: MediaQuery.of(context).size.height * 0.3,
                  fit: BoxFit.fitHeight,
                ),
                TypewriterAnimatedTextKit(
                    duration: Duration(seconds: 8),
                    onTap: () {
                      print("Tap Event");
                    },
                    text: [
                      "Startup Dictionary",
                      "Swipe Right to Explore",
                    ],
                    textStyle: TextStyle(
                      fontSize: 40.0,
                      letterSpacing: 1.5,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                    alignment:
                        AlignmentDirectional.topStart // or Alignment.topLeft
                    ),
              ],
            ),
          ),
        ),
      ),
    );

    for (var i = 0; i < numb - 1; i++) {
      print("from vocabulary " + widget.word[i]);
      val.add(
        Center(
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL, // default
            front: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.green,
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       top: MediaQuery.of(context).size.height * 0.4),
                      //   child:
                      AutoSizeText(
                        widget.word[i],
                        textAlign: TextAlign.center,
                        maxLines: 10,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                        ),
                      ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       top: MediaQuery.of(context).size.height * 0.3),
                      //   child:
                      Text(
                        "Tap to Learn!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                      // ),
                    ],
                  )),
            ),
            back: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: AutoSizeText(
                  widget.meaning[i].replaceAll(".", ".\n\n"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    // fontSize: 18.0,
                  ),
                  maxLines: 20,
                  maxFontSize: 28,
                  minFontSize: 16,
                ),
              ),
            ),
          ),
        ),
      );
    }
    val.add(
      Center(
        child: FlipCard(
          direction: FlipDirection.HORIZONTAL, // default
          front: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.green,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // textBaseline: TextBaseline.alphabetic,
                // verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       top: MediaQuery.of(context).size.height * 0.4),
                  // child:
                  Text(
                    widget.word[numb - 1],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                    ),
                  ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       top: MediaQuery.of(context).size.height * 0.3),
                  //   child:
                  Text(
                    "Tap to Learn!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          back: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.meaning[numb - 1].replaceAll(".", ".\n\n"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      OutlineButton(
                        borderSide: BorderSide(color: Colors.green),
                        onPressed: () {
                          List<dynamic> arguments = [
                            widget.modNum,
                            widget.index + 1
                          ];
                          orderManagement.moveNextIndex(context, arguments);
                        },
                        child: Container(
                          // width: MediaQuery.of(context).size.width * 0.25,
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Next",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15.0,
                                ),
                              ),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return val;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          GestureDetector(
            child: Icon(
              Icons.home,
            ),
            onTap: () {
              showDialog<bool>(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    content:
                        Text("Are you sure you want to return to Home Page? "),
                    title: Text(
                      "Warning!",
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          // Navigator.of(context).popUntil(ModalRoute.withName("/QuoteLoading"));
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName("TimelinePage"));
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "No",
                          style: TextStyle(color: Colors.green),
                        ),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream: db
              .collection("vocabulary")
              .where("module", "==", widget.modNum)
              .onSnapshot,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  PageIndicatorContainer(
                    indicatorColor: Colors.grey[100],
                    align: IndicatorAlign.top,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                    indicatorSpace: 10.0,
                    indicatorSelectorColor: Colors.black,
                    shape:
                        IndicatorShape.roundRectangleShape(size: Size(30, 10)),
                    length: snapshot.data.docs[0].data()['words'].length+1,
                    pageView: PageView(
                      physics: BouncingScrollPhysics(),
                      controller: controller,
                      onPageChanged: (int i) {
                        print(i);
                      },
                      children: generate(snapshot.data.docs[0].data()['words'],snapshot.data.docs[0].data()['meaning']),
                    ),
                  ),
                ],
              );
            }
            return Container();
          }),
    );
  }
}
