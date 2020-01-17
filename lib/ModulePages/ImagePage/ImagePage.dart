// import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/globalKeys.dart';
import '../../ModuleOrderController/Types.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;

class ImagePagePage extends StatefulWidget {
  ImagePagePage({
    Key key,
    this.modNum,
    this.title,
    this.index,
    this.headding,
  }) : super(key: key);
  String title, headding;
  int modNum, index;

  @override
  _ImagePagePageState createState() => _ImagePagePageState();
}

class _ImagePagePageState extends State<ImagePagePage>
    with SingleTickerProviderStateMixin {
  fs.Firestore db = fb.firestore();

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Heading in ImagePage is " + widget.headding);
    return CustomeOffline(
      onConnetivity: Scaffold(
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
          backgroundColor: Colors.white,
          body: Builder(
            builder: (context) {
              return StreamBuilder(
                stream: db
                    .collection("ImagePage")
                    .where("module", "==", widget.modNum)
                    .where("order", "==", widget.index)
                    .onSnapshot,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.009,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.1,
                                left: MediaQuery.of(context).size.width * 0.05,
                              ),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      snapshot.data.docs[index]
                                          .data()["content"][1],
                                      textAlign: TextAlign.center,
                                      //"Startup or Job",
                                      style: TextStyle(
                                          fontFamily: "sans-serif",
                                          color: Colors.green,
                                          fontSize: 23.0,
                                          letterSpacing: 1.2,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
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
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  onPressed: () {
                                                    // Navigator.of(context).popUntil(ModalRoute.withName("/QuoteLoading"));
                                                    Navigator.of(context)
                                                        .popUntil(
                                                            ModalRoute.withName(
                                                                "TimelinePage"));
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text(
                                                    "No",
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, false);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  // top: MediaQuery.of(context).size.height * 0.1,
                                  // left: MediaQuery.of(context).size.height * 0.01,
                                  ),
                              // child: Image.asset(
                              //   widget.title,
                              //   height: MediaQuery.of(context).size.height * 0.7,
                              // ),
                              child: (widget.title.contains("assets/Images"))
                                  ? Image.asset(
                                      snapshot.data.docs[index]
                                          .data()["content"][0],
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      fit: BoxFit.contain,
                                    )
                                  : Image.network(
                                      widget.title,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      fit: BoxFit.contain,
                                    ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                // top: MediaQuery.of(context).size.height * 0.05,
                                left: MediaQuery.of(context).size.height * 0.1,
                                right: MediaQuery.of(context).size.height * 0.1,
                              ),
                              child: OutlineButton(
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 1.5),
                                  onPressed: () {
                                    List<dynamic> arguments = [
                                      widget.modNum,
                                      widget.index + 1
                                    ];
                                    orderManagement.moveNextIndex(
                                        context, arguments);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Next",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        );
                      },
                    );
                  }
                  return Container();
                },
              );
            },
          )),
    );
  }
}
