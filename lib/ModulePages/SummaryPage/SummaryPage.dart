import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/VentureBuilder/TabUI/module_controller.dart';
import 'package:startupreneur/globalKeys.dart';
import 'package:startupreneur/timeline/MainRoadmap.dart';
// import '../socialize/socialize.dart';
import '../../ModuleOrderController/Types.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;

import '../../saveProgress.dart';

class SummaryTheoryPage extends StatefulWidget {
  SummaryTheoryPage(
      {Key key,
      this.content,
      this.button,
      this.modNum,
      this.title,
      this.index,
      this.image})
      : super(key: key);
  String content, button, title, image;
  int modNum, index;

  @override
  _SummaryTheoryPageState createState() => _SummaryTheoryPageState();
}

class _SummaryTheoryPageState extends State<SummaryTheoryPage> {
  String data;
  int item = 0;
  bool isClicked = false;
  List<String> _listViewData = [
    // "Swipe Right / Left to remove",
    // "Swipe Right / Left to remove",
  ];
  fs.Firestore db = fb.firestore();

  ModuleTraverse traverse;

  _onSubmit() {
    setState(() {
      item;
      if (item <= data.split(". ").length) {
        print("data.split(" ").length = " +
            data.split(". ").length.toString() +
            data.split(". ").toString());
        // for (var item in ) {
        if (data.split(". ")[item].length > 3) {
          _listViewData.add(data.split(". ")[item]);
        }
        item++;

        // }

      }

// _listViewData.add(_textController.text);
    });
  }

  List<Widget> convertTolist(content,button) {
    List<Widget> list = [];
    list.addAll(_listViewData.map((data) {
      // return Dismissible(
      //   key: Key(data),
      //   child: ListTile(
      //     title: Text(data),
      //   ),
      // );
      print(_listViewData);
      return Card(
          elevation: 0,
          margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                child: AutoSizeText(
                  data,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 0.5,
                    // fontFamily: "Open Sans",
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ));
    }).toList());

    if (item < data.split(". ").length) {
      list.add(Center(
          child: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
        child: OutlineButton(
          highlightedBorderColor: Colors.greenAccent,
          borderSide: BorderSide(color: Colors.green),
          onPressed: _onSubmit,
          child: Text(
            'Tap here to Continue',
            style: TextStyle(
              // letterSpacing: 1.5,
              // fontFamily: "Open Sans",
              color: Colors.green,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          color: Colors.white,
        ),
      )));
    } else {
      list.add(Center(
          child: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
        child: OutlineButton(
          highlightedBorderColor: Colors.greenAccent,
          borderSide: BorderSide(color: Colors.green),
          onPressed: () {
            if (!isClicked) {
              isClicked = true;
              List<dynamic> arguments = [widget.modNum, widget.index + 1];
              // orderManagement.moveNextIndex(context, arguments);
              traverse.navigate();
            }
          },
          child: Text(
            widget.button,
            style: TextStyle(
              // letterSpacing: 1.5,
              // fontFamily: "Open Sans",
              color: Colors.green,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          color: Colors.white,
        ),
      )));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    traverse =  Provider.of<ModuleTraverse>(context);
    data = widget.content;
    return
    //  CustomeOffline(
    //   onConnetivity:
       Scaffold(
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.navigate_before,
              color: Colors.black,
            ),
            onPressed: () {
              traverse.navigateBack();
            },
          ),
          elevation: 0,
          actions: <Widget>[
            GestureDetector(
              child: Icon(Icons.home),
              onTap: () {
                showDialog<bool>(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        content: Text(
                            "Are you sure you want to return to Home Page? "),
                        title: Text(
                          "Warning!",
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              "Yes",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                               SaveProgress.preferences(
                                      widget.modNum, widget.index);
                              // Navigator.of(context).popUntil(ModalRoute.withName("/QuoteLoading"));
                              // Navigator.of(context).popUntil(
                              //     ModalRoute.withName("TimelinePage"));
                               Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => TimelinePage()),
                            );
                            },
                          ),
                          FlatButton(
                            child: Text(
                              "No",
                              style: TextStyle(color: Colors.green),
                            ),
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Builder(
            builder: (context) {
              return StreamBuilder(
                stream: db.collection('summary').where("module","==", widget.modNum).onSnapshot,
                builder: (context, snapshot) {
                  return Stack(
                    children: <Widget>[
                      ClipPath(
                        clipper: WaveClipperOne(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                          ),
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.05,
                                left: MediaQuery.of(context).size.width * 0.02),
                            child: Text(
                              snapshot.data.docs[0].data()['content'][0],
                              //"Startup or Job",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "sans-serif",
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.15,
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.04,
                              ),
                              child: Image.asset(
                                snapshot.data.docs[0].data()['content'][3],
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.75,
                                alignment: Alignment.center,
                              ),
                            ),
                            Column(
                              children: convertTolist( snapshot.data.docs[0].data()['content'][1], snapshot.data.docs[0].data()['content'][2],),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      // ),
    );
  }
}
