import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:page_indicator/page_indicator.dart';

class ModuleVocabulary extends StatefulWidget {
  ModuleVocabulary({Key key, this.modNum}) : super(key: key);
  int modNum;
  @override
  _ModuleVocabularyState createState() => _ModuleVocabularyState();
}

class _ModuleVocabularyState extends State<ModuleVocabulary> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  PageController controller;
  Firestore db = Firestore.instance;
  final List<String> words = [];
  final List<String> meanings = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController();
    widget.modNum = 1;

    db
        .collection("vocabulary")
        .where("module", isEqualTo: 2)
        .getDocuments()
        .then((document) {
      document.documents.forEach((value) {
        // words.clear();
        // meanings.clear();
        for (String i in value["word"]) {
          print(i);
          setState(() {
            words.add(i);
          });
        }
        for (String i in value["meaning"]) {
          setState(() {
            meanings.add(i);
          });
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget listOfWords(BuildContext context) {
    List<Widget> wordList = [];
    StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("vocabulary")
          .where("module", isEqualTo: 1)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        switch (snapshot.data) {
          case null:
            return CircularProgressIndicator();
            break;
          default:
            words.clear();
            meanings.clear();
            snapshot.data.documents.forEach((documents) {
              for (String i in documents["word"]) {
                words.add(i);
              }
              for (String i in documents["meaning"]) {
                meanings.add(i);
              }
            });
            return null;
        }
      },
    );
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        // ClipPath(
        //   clipper: WaveClipperOne(),
        //   child: Container(
        //     decoration: BoxDecoration(color: Colors.green),
        //     height: MediaQuery.of(context).size.height * 0.2,
        //     width: MediaQuery.of(context).size.width,
        //     child: Padding(
        //       padding: EdgeInsets.only(
        //           top: MediaQuery.of(context).size.height * 0.1),
        //       child: Text("data"),
        //     ),
        //   ),
        // ),
        PageIndicatorContainer(
          indicatorColor: Colors.black,
          align: IndicatorAlign.bottom,
          indicatorSpace: 10.0,
          indicatorSelectorColor: Colors.green,
          shape: IndicatorShape.roundRectangleShape(size: Size(50, 10)),
          length: 3,
          pageView: PageView(
            controller: controller,
            children: <Widget>[
              Center(
                child: FlipCard(
                  direction: FlipDirection.HORIZONTAL, // default
                  front: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.6,
                      color: Colors.green,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          words[0],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      )),
                  back: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.6,
                    color: Colors.grey,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        meanings[0],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
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
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.6,
                      color: Colors.green,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          words[1],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      )),
                  back: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.6,
                    color: Colors.grey,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        meanings[1],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
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
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.6,
                      color: Colors.green,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          words[2],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      )),
                  back: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.6,
                    color: Colors.grey,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        meanings[2],
                        style: TextStyle(
                          color: Colors.white,
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
    ));
  }
}
