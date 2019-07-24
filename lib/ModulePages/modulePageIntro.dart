import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ModulePages/quiz/quiz_page.dart';


class ModulePageIntro extends StatefulWidget {
  ModulePageIntro({Key key, this.modNum}) : super(key: key);
  final int modNum;
  @override
  _ModulePageIntroState createState() => _ModulePageIntroState();
}

class _ModulePageIntroState extends State<ModulePageIntro> {
  List<dynamic> list = [];
  dynamic dataSnapshot;

  @override
  initState(){
    super.initState();
    print("init hello");
  }
  List<Widget> wList(String index) {
    List<Widget> listWidget = new List<Widget>();
    for (dynamic i in dataSnapshot["$index"]) {
      print("val i $i");
      listWidget.add(
        ListTile(
          leading: Icon(Icons.done),
        title: Text(i),
      ));
    }
    print(listWidget);
    return listWidget;
  }

  List<Widget> wExList() {
    List<Widget> listWidget = new List<Widget>();
    for (int index = 0; index < list.length; index++) {
      listWidget.add(ExpansionTile(
        leading: Icon(Icons.arrow_forward_ios),
        title: Text(
          list[index],
          style: TextStyle(color: Colors.green),
        ),
        children: wList(index.toString()),
      ));
    }
    listWidget.add(
     RaisedButton(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.green,
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => QuizPage(modNum: widget.modNum),
            ),
          );
        },
        child: Icon(
          Icons.navigate_next,
          size: 40.0,
        ),
      ),
    );
    print(listWidget);
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            expandedHeight: 200,
            // backgroundColor: Theme.of(context).primaryColorDark,
            backgroundColor: Colors.black,
            pinned: true,
            title: Text(
              "Course Overview",
              style: TextStyle(color: Colors.white),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/Images/start_up.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("module")
                      .where("id", isEqualTo: 2)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    // if(snapshot.error){
                    //   return Text("Error while fetching");
                    // }
                    switch (snapshot.data) {
                      case null:
                        return Text("Loading ...");
                      default:
                        snapshot.data.documents.forEach((document) {
                          dataSnapshot = document;
                          print(document.data["overview"]);
                          list.clear();
                          for (dynamic i in document.data["overview"]) {
                            list.add(i);
                          }
                        });
                        return Column(
                          children: wExList(),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
