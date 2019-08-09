import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flip_card/flip_card.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:flip_card/flip_card.dart';

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
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dataRetrieve();
  }

  Widget _buildFrontWidget(String word) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: MediaQuery.of(context).size.height*0.5,
        color: Colors.grey,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              word,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              onPressed: () => _foldingCellKey?.currentState?.toggleFold(),
              child: Text(
                "Check for meaning",
              ),
              textColor: Colors.white,
              color: Colors.green,
              splashColor: Colors.white.withOpacity(0.5),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInnerTopWidget(String word) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.grey,
        alignment: Alignment.center,
        child: Text(
          word,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomWidget(String word, String meaning) {
    return Container(
      height: MediaQuery.of(context).size.height*0.5,
      color: Color(0xFFecf2f9),
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Material(
          type: MaterialType.canvas,
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  meaning,
                  style: TextStyle(
                    fontSize: 16.0,
                    
                  ),
                ),
              )),
        ),
      ),
    );
  }

  void popDialog(BuildContext context, String word, String meaning) {
    print("$meaning");
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          // child: SimpleFoldingCell(
          //   key: _foldingCellKey,
          //   cellSize: Size(MediaQuery.of(context).size.width, 250),
          //   padding: EdgeInsets.all(15),
          //   animationDuration: Duration(milliseconds: 300),
          //   borderRadius: 10,
          //   frontWidget: _buildFrontWidget(word),
          //   innerTopWidget: _buildInnerTopWidget(word),
          //   innerBottomWidget: _buildBottomWidget(word, meaning),
          // ),
          child: FlipCard(
                    direction: FlipDirection.HORIZONTAL, // default
                    front: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width*0.75,
                      height: MediaQuery.of(context).size.height*0.6,
                      color: Colors.green,
                      child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.1),
                                child: Text(
                                  word,
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
                                        0.1),
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
                      width: MediaQuery.of(context).size.width*0.75,
                      height: MediaQuery.of(context).size.height*0.6,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(17),
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
                      ),
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.06,
            iconTheme:IconThemeData(color: Colors.black),
            title: Text("Startup Dictionary",style: TextStyle(color: Colors.white)),
            pinned: true,
            backgroundColor: Colors.green,
//            flexibleSpace: FlexibleSpaceBar(
////              background: Image.asset(
////                "assets/Images/vocabulary3.png",
////                fit: BoxFit.fitHeight,
////                // height: 200,
////              ),
//            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
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

                        for (int i = 0;i<snapshot.data.documents.length;i++){
                          for(String k in snapshot.data.documents[i].data["meaning"] ){
                           listMeaning.add(k);
                          }
                        }
                        // print(listGiven);
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: listGiven.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                // print(" ${snapshot.data.documents[0].data["meaning"][index]}");
                                print(index);
                                popDialog(
                                  context,
                                  listGiven[index],
                                  listMeaning[index],
                                );
                              },
                              leading: Icon(Icons.book),
                              title: Text(listGiven[index]),
                            );
                            // listGenerated(context,index,snapshot.data.documents.length,snapshot);
                          },
                        );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
