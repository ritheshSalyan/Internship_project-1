import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/VentureBuilder/TabUI/module_controller.dart';
import 'package:startupreneur/globalKeys.dart';
import 'ImageViewer.dart';
import '../../ModuleOrderController/Types.dart';
// import 'package:extended_image/extended_image.dart';
import '../../saveProgress.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;

class DiscussionPage extends StatefulWidget {
  DiscussionPage(
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
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  String data;
  int item = 0;
  List<String> _listViewData = [
    // "Swipe Right / Left to remove",
    // "Swipe Right / Left to remove",
  ];
  fs.Firestore db = fb.firestore();

  ModuleTraverse traverse;

  @override
  void initState() {
    super.initState();
    Analytics.analyticsBehaviour("Discussion_Page_Module", "Discussion_Page");
    //  SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    item = 0;
    _listViewData = [];
    data = "";
    print("INside initstate Discussion");
    // convertTolist();
  }

  @override
  dispose() {
    //  SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]).then((_){
    //   print("Dispose of oirentation done");
    // });
    super.dispose();
  }

  _onSubmit() {
    final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');

    setState(() {
      // item;
      if (item <= data.split(". ").length) {
        // print("data.split(' ').length = " +
        //     data.split(". ").length.toString() +
        //     data.split(". ").toString());
        // for (var item in ) {
        if (data.split(". ")[item].length > 3) {
          String temp = data.split(". ")[item];
          // print("88888888888888888"+temp+alphanumeric.hasMatch(temp[temp.length-1]).toString());
          if (alphanumeric.hasMatch(temp[temp.length - 1])) {
            _listViewData.add(temp + ".");
          } else {
            _listViewData.add(temp);
          }
        }
        item++;

        // }

      }

// _listViewData.add(_textController.text);
    });
  }

  List<Widget> convertTolist() {
    List<Widget> list= [];
    list.addAll(_listViewData.map((data) {
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
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
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
        child: FlatButton(
          onPressed: () {
            List<dynamic> arguments = [widget.modNum, widget.index + 1];
            // orderManagement.moveNextIndex(context, arguments);
            data = "";
            traverse.navigate();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(widget.button,
                  style: TextStyle(fontWeight: FontWeight.w700)),
              Icon(Icons.navigate_next),
            ],
          ),
        ),
      ));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    traverse = Provider.of<ModuleTraverse>(context);
    Widget image = SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.2,
    );

    if (widget.image != "") {
      print("Title here ${widget.image}");
      if ((widget.image.contains("assets/"))) {
        image = Image.asset(
          widget.image,
          semanticLabel: "Image",
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.2,
        );
      } else {
        // print("Inside Network");
        image = Image.network(
          widget.image,
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.2,
          fit: BoxFit.contain,
        );
      }
    }
    if(data.compareTo(widget.content)!=0){
        data = widget.content;
        _listViewData = [];
        item = 0;
    }

    print("data is  is $data    ++++++++++++++++++++++++ ${ data.compareTo(widget.content)}");
    print("List VIEW DATA IS $_listViewData");
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
          elevation: 0,
          actions: <Widget>[
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(Icons.home),
              ),
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
                              Navigator.of(context).popUntil(
                                  ModalRoute.withName("TimelinePage"));
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
              return Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: WaveClipperOne(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                      ),
                      height: MediaQuery.of(context).size.height * 0.18,
                      width: double.infinity,
                      child: Text(" "),
                    ),
                  ),
                  Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    widget.title,
                                    // snapshot.data.docs[index].data()['title'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "sans-serif",
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                          // left: MediaQuery.of(context)
                                          //         .size
                                          //         .width *
                                          //     0.14,
                                        ),
                                        child: image,// snapshot.data.docs[index].data()['image'],
                                      ),
                                      // (snapshot.data.docs[index].data()['image'] != "")
                                      //     ? IconButton(
                                      //         icon: Icon(
                                      //           Icons.zoom_out_map,
                                      //           color: Colors.black,
                                      //         ),
                                      //         onPressed: () {
                                      //           Navigator.of(context)
                                      //               .push(MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 ImageViewer(
                                      //               image: snapshot.data.docs[index].data()['image'],
                                      //             ),
                                      //             fullscreenDialog: true,
                                      //           ));
                                      //         },
                                      //       )
                                      //     : SizedBox(),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: convertTolist(),
                                  ),
                                ],
                              ),
                  // StreamBuilder(
                  //   stream: db
                  //       .collection("discussion")
                  //       .where("module", "==", widget.modNum)
                  //       .where("order", "==", orderManagement.currentIndex)
                  //       .onSnapshot,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       return Padding(
                  //         padding: EdgeInsets.only(
                  //           // top: MediaQuery.of(context).size.height * 0.0,
                  //         ),
                  //         child: ListView.builder(
                  //           itemCount: snapshot.data.docs.length,
                  //           shrinkWrap: true,
                  //           itemBuilder: (context, index) {
                  //             return Column(
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: <Widget>[
                  //                 Text(
                  //                   snapshot.data.docs[index].data()['title'],
                  //                   textAlign: TextAlign.center,
                  //                   style: TextStyle(
                  //                     fontFamily: "sans-serif",
                  //                     color: Colors.white,
                  //                     fontSize: 25.0,
                  //                     fontWeight: FontWeight.w700,
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   height: 15,
                  //                 ),
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.center,
                  //                   children: <Widget>[
                  //                     Padding(
                  //                       padding: EdgeInsets.only(
                  //                         left: MediaQuery.of(context)
                  //                                 .size
                  //                                 .width *
                  //                             0.14,
                  //                       ),
                  //                       child: snapshot.data.docs[index].data()['image'],
                  //                     ),
                  //                     (snapshot.data.docs[index].data()['image'] != "")
                  //                         ? IconButton(
                  //                             icon: Icon(
                  //                               Icons.zoom_out_map,
                  //                               color: Colors.black,
                  //                             ),
                  //                             onPressed: () {
                  //                               Navigator.of(context)
                  //                                   .push(MaterialPageRoute(
                  //                                 builder: (context) =>
                  //                                     ImageViewer(
                  //                                   image: snapshot.data.docs[index].data()['image'],
                  //                                 ),
                  //                                 fullscreenDialog: true,
                  //                               ));
                  //                             },
                  //                           )
                  //                         : SizedBox(),
                  //                   ],
                  //                 ),
                  //                 Column(
                  //                   mainAxisSize: MainAxisSize.min,
                  //                   children: convertTolist(),
                  //                 ),
                  //               ],
                  //             );
                  //           },
                  //         ),
                  //       );
                  //     }
                  //     return Container();
                  //   },
                  // ),
                ],
              );
            },
          ),
        ),
      // ),
    );
  }
}
