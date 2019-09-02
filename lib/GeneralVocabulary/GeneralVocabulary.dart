import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flip_card/flip_card.dart';
// import 'package:folding_cell/folding_cell.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:startupreneur/NoInternetPage/NoNetPage.dart';

class ItemList {
  List<String> list = [];
}

class Vocabulary extends StatefulWidget {
  @override
  _VocabularyState createState() => _VocabularyState();
}

class _VocabularyState extends State<Vocabulary> {
  Firestore db = Firestore.instance;
  List<String> listGiven = [];
  List<String> listMeaning = [];
  // final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dataRetrieve();
  }

  void popDialog(BuildContext context, String word, String meaning) {
    print("$meaning");
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL, // default
            front: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              color: Colors.green,
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1),
                        child: Material(
                          child: Text(
                            word,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                            ),
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1),
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            "Tap to Learn!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            back: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.all(17),
                  child: Material(
                    color: Colors.transparent,
                    child: AutoSizeText(
                      meaning.replaceAll(".", ".\n\n"),
                      minFontSize: 12,
                      maxFontSize: 20,
                      maxLines: 20,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        // fontSize: 18.0,
                      ),
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }

  List<Widget> listGenerated(BuildContext context, int index, int length,
      AsyncSnapshot<QuerySnapshot> snapshot) {
    List<Widget> list = [];
    for (int i = index; i < length; i++) {
      list.add(ListTile(
        onTap: () {
          // print(" ${snapshot.data.documents[0].data["meaning"][index]}");
          popDialog(context, snapshot.data.documents[0].data["word"][index],
              snapshot.data.documents[0].data["meaning"][index]);
        },
        leading: Icon(Icons.book),
        title: Text(snapshot.data.documents[i].data["word"][index]),
      ));
    }
    print(list);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Startup Dictionary",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: OfflineBuilder(
        connectivityBuilder:
            (context, ConnectivityResult connectivity, Widget child) {
          final connected = connectivity != ConnectivityResult.none;
          if (connected) {
            child = SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  StreamBuilder<QuerySnapshot>(
                    stream:
                        Firestore.instance.collection("vocabulary").snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      // return Text("value ${snapshot.data.documents[0].data["word"].length}");
                      print("vocabulary ${snapshot.data}");
                      if (snapshot.hasError) {
                        print("error");
                        // return Text("Error ${snapshot.error}");
                      }
                      switch (snapshot.data) {
                        case null:
                          return CircularProgressIndicator();
                          break;
                        default:
                          listGiven.clear();
                          for (int i = 0;
                              i < snapshot.data.documents.length;
                              i++) {
                            for (String k
                                in snapshot.data.documents[i].data["word"]) {
                              print(k);
                              listGiven.add(k);
                            }
                          }

                          for (int i = 0;
                              i < snapshot.data.documents.length;
                              i++) {
                            for (String k
                                in snapshot.data.documents[i].data["meaning"]) {
                              listMeaning.add(k);
                            }
                          }
                          // print(listGiven);
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listGiven.length,
                            itemBuilder: (context, index) {
                              // return ListTile(
                              //   onTap: () {
                              //     // print(" ${snapshot.data.documents[0].data["meaning"][index]}");
                              //     print(index);
                              //     popDialog(
                              //       context,
                              //       listGiven[index],
                              //       listMeaning[index],
                              //     );
                              //   },
                              //   leading: Icon(Icons.book),
                              //   title: Text(listGiven[index]),
                              // );
                              return GestureDetector(
                                onTap: () {
                                  print(index);
                                  popDialog(
                                    context,
                                    listGiven[index],
                                    listMeaning[index],
                                  );
                                },
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.book),
                                        Text(listGiven[index]),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              // listGenerated(context,index,snapshot.data.documents.length,snapshot);
                            },
                          );
                      }
                    },
                  ),
                ],
              ),
            );
          }
          return child;
        },
        child: NoNetPage(),
      ),
    );
  }
}
