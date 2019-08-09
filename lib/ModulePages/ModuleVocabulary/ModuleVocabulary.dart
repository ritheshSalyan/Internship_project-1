import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:page_indicator/page_indicator.dart';
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
  Firestore db = Firestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController();
    // widget.modNum ;
    print("init inisde ${widget.word}");
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
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: MediaQuery.of(context).size.height*0.2),
                          Image.asset(
                            "assets/Images/vocabulary.png",
                            height: MediaQuery.of(context).size.height*0.3,
                            fit: BoxFit.fitHeight,
//                            height: 200,
                          ),
                          TypewriterAnimatedTextKit(
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
                              alignment: AlignmentDirectional
                                  .topStart // or Alignment.topLeft
                              ),
                        ],
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
                            fontSize: 20.0,
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
                                    fontSize: 20.0,
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
                            fontSize: 20.0,
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
                                  top:
                                      MediaQuery.of(context).size.height * 0.4),
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
                                  top:
                                      MediaQuery.of(context).size.height * 0.3),
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
                                top: MediaQuery.of(context).size.height * 0.05,
                                // left: MediaQuery.of(context).size.width *0.5,
                              ),
                              child: OutlineButton(
                                borderSide: BorderSide(color: Colors.white),
                                onPressed: () {
                                  List<dynamic> arguments = [
                                    widget.modNum,
                                    widget.index + 1
                                  ];
                                  orderManagement.moveNextIndex(
                                      context, arguments);
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
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
                                ),
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
