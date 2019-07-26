import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startupreneur/ModuleOrderController/Types.dart' as prefix0;
import '../quiz/quiz_page.dart';
import '../../ModuleOrderController/Types.dart';

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
  initState() {
    super.initState();
    print("init hello");
  }

  List<Type> convert(List<dynamic> list ){
    List<Type> typeList = [];
      for (var item in list) {
      switch(item){
      case "Type.quote":
        print("quote");
        typeList.add(Type.quote);
        break;


       case "Type.quiz":
        print("quiz");
        typeList.add(Type.quiz);
        break;


       case "Type.activity":
        print("activity");
        typeList.add(Type.activity);
        break;


       case "Type.decisionGame":
        print("decisionGame");
        typeList.add(Type.decisionGame);
        break;


       case "Type.caseStudy":
        print("caseStudy");
        typeList.add(Type.caseStudy);
        break;


       case "Type.video":
        print("video");
       typeList.add(Type.video);
        break;


       case "Type.overView":
        print("overView");
        typeList.add(Type.overView);
        break;


        case "Type.theory":
        print("theory");
        typeList.add(Type.theory);
        break;


       case "Type.summary":
       typeList.add(Type.summary);
        print("summary");
        break;
        
    }
      }
      return typeList;

  }

  List<Widget> wList(String index) {
    List<Widget> listWidget = new List<Widget>();
    for (dynamic i in dataSnapshot["$index"]) {
      print("val i $i");
      listWidget.add(ListTile(
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
          List<dynamic> arguments = [widget.modNum];
          orderManagement.moveNextIndex(context, arguments);
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
                "assets/Images/${widget.modNum}.png",
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
                      .where("id", isEqualTo: widget.modNum)
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
                          orderManagement.order = convert(document.data["order"]);

                          print("orderManagement.order "+orderManagement.order.toString());
                           //=
                          // print(
                          //     "orderManagement.order = ${document.data}"); //[Type.overView,Type.quiz,Type.decisionGame];
                        });

                        // orderManagement.order = [Type.overView,Type.quiz,Type.theory,Type.video];

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
