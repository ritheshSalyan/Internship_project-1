import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flip_card/flip_card.dart';
import 'package:folding_cell/folding_cell.dart';

class ItemList {
  List<String> list = [];
}

class Vocabulary extends StatefulWidget {
  @override
  _VocabularyState createState() => _VocabularyState();
}

class _VocabularyState extends State<Vocabulary> {
  Firestore db = Firestore.instance;
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
      color: Color(0xFFecf2f9),
      alignment: Alignment.bottomCenter,
      child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Material(
            type: MaterialType.canvas,
            child: SingleChildScrollView(
              child: Text(
              meaning,
              style: TextStyle(fontSize: 16.0),
            ),
            ),
          ),),
    );
  }

  void popDialog(BuildContext context, String word, String meaning) {
    print("$meaning");
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          child: SimpleFoldingCell(
            key: _foldingCellKey,
            cellSize: Size(MediaQuery.of(context).size.width, 125),
            padding: EdgeInsets.all(15),
            animationDuration: Duration(milliseconds: 300),
            borderRadius: 10,
            frontWidget: _buildFrontWidget(word),
            innerTopWidget: _buildInnerTopWidget(word),
            innerBottomWidget: _buildBottomWidget(word, meaning),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            title: Text("Start-up Glossary"),
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/Images/vocabulary.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream:
                      Firestore.instance.collection("vocabulary").snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    // return Text("value ${snapshot.data.documents[0].data["word"].length}");
                    if (snapshot.hasError) {
                      print("error");
                      // return Text("Error ${snapshot.error}");
                    }
                    switch (snapshot.data) {
                      case null:
                        return Text("hello");
                        break;
                      default:
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              snapshot.data.documents[0].data["word"].length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                onTap: () {
                                  // print(" ${snapshot.data.documents[0].data["meaning"][index]}");
                                  popDialog(
                                      context,
                                      snapshot.data.documents[0].data["word"]
                                          [index],
                                      snapshot.data.documents[0].data["meaning"]
                                          [index]);
                                },
                                leading: Icon(Icons.book),
                                title: Text(snapshot
                                    .data.documents[0].data["word"][index]));
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
