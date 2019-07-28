import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:page_indicator/page_indicator.dart';

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
  Firestore db = Firestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController();
    widget.modNum = 1;
    print("init inisde ${widget.word}");
    // db
    //     .collection("vocabulary")
    //     .where("module", isEqualTo: 2)
    //     .getDocuments()
    //     .then((document) {
    //   document.documents.forEach((value) {
    //     // words.clear();
    //     // meanings.clear();
    //     for (String i in value["word"]) {
    //       print(i);
    //       setState(() {
    //         words.add(i);
    //       });
    //     }
    //     for (String i in value["meaning"]) {
    //       setState(() {
    //         meanings.add(i);
    //       });
    //     }
    //   });
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageIndicatorContainer(
            indicatorColor: Colors.white,
            align: IndicatorAlign.top,
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            indicatorSpace: 10.0,
            indicatorSelectorColor: Colors.black,
            shape: IndicatorShape.roundRectangleShape(size: Size(50, 10)),
            length: 4,
            pageView: PageView(
              physics: BouncingScrollPhysics(),
              controller: controller,
              onPageChanged: (int i) {
                print(i);
              },
              children: <Widget>[
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.green,
                    child: SizedBox(
                      width: 250.0,
                      child: TypewriterAnimatedTextKit(
                          onTap: () {
                            print("Tap Event");
                          },
                          text: [
                            "Startup Dictionary",
                            "Swipe Right",
                          ],
                          textStyle: TextStyle(
                              fontSize: 42.0,
                              fontFamily: "Open Sans",
                              letterSpacing: 1.5),
                          textAlign: TextAlign.start,
                          alignment: AlignmentDirectional
                              .topStart // or Alignment.topLeft
                          ),
                    ),
                  ),
                ),
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
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.4),
                                child: Text(
                                  widget.word[0],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.3),
                                child: Text(
                                  "Tap to Learn!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
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
                        child: Text(
                          widget.meaning[0].replaceAll(".", ".\n\n"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.4),
                                child: Text(
                                  widget.word[1],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.3),
                                child: Text(
                                  "Tap to Learn!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
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
                        child: Text(
                          widget.meaning[1].replaceAll(".", ".\n\n"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.4),
                                child: Text(
                                  widget.word[2],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.3),
                                child: Text(
                                  "Tap to Learn!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.05,
                                  // left: MediaQuery.of(context).size.width *0.5,
                                ),
                                child: OutlineButton(
                                    borderSide: BorderSide(color: Colors.white),
                                    onPressed: () {},
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "Activity",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Icon(
                                            Icons.navigate_next,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )),
                                //   child: IconButton(
                                //     onPressed: (){},
                                //     icon: Icon(Icons.navigate_next),

                                //   // ),
                              ),
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
                        child: Text(
                          widget.meaning[2].replaceAll(".", ".\n\n"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}