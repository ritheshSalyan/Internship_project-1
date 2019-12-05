import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startupreneur/ModuleOrderController/Types.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/globalKeys.dart';
import '../../ModuleOrderController/Types.dart';

class ModulePageIntro extends StatefulWidget {
  ModulePageIntro({Key key, this.modNum, this.index}) : super(key: key);
  final int modNum, index;
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

  // List<Type> convert(List<dynamic> list ){
  //   List<Type> typeList = [];
  //     for (var item in list) {
  //     switch(item){
  //     case "Type.quote":
  //       print("quote");
  //       typeList.add(Type.quote);
  //       break;

  //     case "Type.vocabulary":
  //       print("vocabulary");
  //       typeList.add(Type.vocabulary);
  //       break;

  //      case "Type.quiz":
  //       print("quiz");
  //       typeList.add(Type.quiz);
  //       break;

  //      case "Type.activity":
  //       print("activity");
  //       typeList.add(Type.activity);
  //       break;

  //      case "Type.decisionGame":
  //       print("decisionGame");
  //       typeList.add(Type.decisionGame);
  //       break;

  //      case "Type.caseStudy":
  //       print("caseStudy");
  //       typeList.add(Type.caseStudy);
  //       break;

  //      case "Type.video":
  //       print("video");
  //      typeList.add(Type.video);
  //       break;

  //      case "Type.overView":
  //       print("overView");
  //       typeList.add(Type.overView);
  //       break;

  //       case "Type.theory":
  //       print("theory");
  //       typeList.add(Type.theory);
  //       break;

  //      case "Type.summary":
  //      typeList.add(Type.summary);
  //       print("summary");
  //       break;

  //       case "Type.discussion":
  //        typeList.add(Type.discussion);
  //       print("summary");
  //       break;

  //       default:
  //           print("Default");

  //   }
  //     }
  //     return typeList;

  // }

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
        initiallyExpanded: false,
        leading: Icon(Icons.arrow_forward_ios),
        title: Text(
          list[index],
          style: TextStyle(color: Colors.green),
        ),
        trailing: Container(
          width: 0,
          height: 0,
        ),
        children: wList(index.toString()),
      ));
    }
    listWidget.add(SizedBox(
      height: 70,
    ));
    listWidget.add(Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: OutlineButton(
        borderSide: BorderSide(
          color: Colors.green,
          width: 1.2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.green,
        onPressed: () {
          List<dynamic> arguments = [widget.modNum, widget.index + 1];
          orderManagement.moveNextIndex(context, arguments);
        },
        child: Icon(
          Icons.navigate_next,
          size: 40.0,
          color: Colors.green,
        ),
      ),
    ));
    print(listWidget);
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return CustomeOffline(
      onConnetivity: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
            bottom: 5.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Page ${widget.index + 1}/${Module.moduleLength}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              expandedHeight: 50,
              // backgroundColor: Theme.of(context).primaryColorDark,
              backgroundColor: Colors.green,
              pinned: true,
              title: Text(
                "Module Overview",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              // flexibleSpace: FlexibleSpaceBar(
              //   background: Image.asset(
              //     "assets/Images/${widget.modNum}.png",
              //     fit: BoxFit.fitHeight,
              //   ),
              // ),
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
                          return Center(
                            child: CircularProgressIndicator(
                              value: null,
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation(
                                Colors.green,
                              ),
                            ),
                          );
                        default:
                          snapshot.data.documents.forEach((document) {
                            dataSnapshot = document;
                            print(document.data["overview"]);
                            list.clear();
                            for (dynamic i in document.data["overview"]) {
                              list.add(i);
                            }
                            //   if(orderManagement.order.isEmpty){
                            //   orderManagement.order = convert(document.data["order"]);

                            print("orderManagement.order " +
                                orderManagement.order.toString());
                            // }
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
      ),
    );
  }
}
