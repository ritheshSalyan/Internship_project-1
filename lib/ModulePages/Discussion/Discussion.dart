import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/globalKeys.dart';
import 'ImageViewer.dart';
import '../../ModuleOrderController/Types.dart';
import 'package:extended_image/extended_image.dart';
import '../../saveProgress.dart';

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

  @override
  void initState() {
    super.initState();
    Analytics.analyticsBehaviour("Discussion_Page_Module", "Discussion_Page");
    //  SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
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
          if (alphanumeric.hasMatch(temp[temp.length-1])) {
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
    List<Widget> list = [];
    list.addAll(_listViewData.map((data) {
      // return Dismissible(
      //   key: Key(data),
      //   child: ListTile(
      //     title: Text(data),
      //   ),
      // );
      // print(_listViewData);
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
        child: FlatButton(
          onPressed: () {
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context)=>SocializeTask(),
            //   )
            // );
            List<dynamic> arguments = [widget.modNum, widget.index + 1];
            orderManagement.moveNextIndex(context, arguments);
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
    Widget image = SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.5,
    );

    if (widget.image != "") {
      print("Title here ${widget.image}");
      if ((widget.image.contains("assets/"))) {
        // print("Inside Assets");
        image = ExtendedImage.asset(
          widget.image,
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.7,
        );
      } else {
        // print("Inside Network");
        image = ExtendedImage.network(
          widget.image,
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.7,
        fit: BoxFit.contain,
        );
      }
    }
    // print("Image is ${}");
    data = widget.content;
    return CustomeOffline(
      onConnetivity: Scaffold(
         bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
               "${widget.index+1}/${Module.moduleLength}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
        appBar: AppBar(
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
                              // Navigator.of(context).popUntil(ModalRoute.withName("/QuoteLoading"));
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
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.0),
                    child: Column(
                      children: <Widget>[
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       top: MediaQuery.of(context).size.height * 0.05,
                        //       left: MediaQuery.of(context).size.width * 0.02),
                        //  Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // children: <Widget>[
                        Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          //"Startup or Job",
                          style: TextStyle(
                            fontFamily: "sans-serif",
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        //     ],
                        //  // ),
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.14),
                              child: image,
                            ),
                            (widget.image != "")
                                ? IconButton(
                                    icon: Icon(
                                      Icons.zoom_out_map,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            ImageViewer(image: widget.image),
                                        fullscreenDialog: true,
                                      ));
                                    },
                                  )
                                : SizedBox(),
                          ],
                        ),

                        Column(
                          // children: <Widget>[

                          //    Card(
                          //       clipBehavior: Clip.antiAliasWithSaveLayer,
                          //       child: Padding(
                          //         padding: EdgeInsets.all(10.0),
                          //         child: Text(
                          //           widget.content,
                          //           //"Those working in startups get jealous when they see their friends drawing a great salary and having a structured life, while, those who are in jobs are upset when they see their startup friends having the flexibility and autonomy to solve problems in their own way. You probably know the workplace basics of each – large companies have set hours and are stricter, while, startups have more flexibility but are more demanding.",
                          //           style: TextStyle(
                          //             fontSize: 18.0,
                          //
                          //             fontWeight: FontWeight.w500,
                          //           ),
                          //         ),
                          //       ),
                          //     ),

                          // ],
                          children: convertTolist(),
                        ),
                        // FlatButton(
                        //   onPressed: () {
                        //     // Navigator.of(context).pushReplacement(
                        //     //   MaterialPageRoute(
                        //     //     builder: (context)=>SocializeTask(),
                        //     //   )
                        //     // );
                        //     List<dynamic> arguments = [
                        //       widget.modNum,
                        //       widget.index+1
                        //     ];
                        //     orderManagement.moveNextIndex(context, arguments);
                        //   },
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: <Widget>[
                        //       Text(widget.button,
                        //           style: TextStyle(fontWeight: FontWeight.w700)),
                        //       Icon(Icons.navigate_next),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
