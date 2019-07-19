import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemList {
  List<String> list = [];
}

class Vocabulary extends StatefulWidget {
  @override
  _VocabularyState createState() => _VocabularyState();
}

class _VocabularyState extends State<Vocabulary> {
  Firestore db = Firestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dataRetrieve();
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
                                  leading: Icon(Icons.book),
                                  title: Text(snapshot
                                      .data.documents[0].data["word"][index]));
                            });
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
