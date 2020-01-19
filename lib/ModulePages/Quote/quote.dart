import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/VentureBuilder/TabUI/module_controller.dart';
import '../ModuleOverview/ModuleOverviewLoading.dart';
import '../../ModuleOrderController/Types.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;

class Quote extends StatefulWidget {
  Quote({Key key, this.modNum, this.quote}) : super(key: key);
  int modNum;
  List<String> quote;
  @override
  _QuoteState createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  fs.Firestore db = fb.firestore();

  ModuleTraverse traverse;

  @override
  Widget build(BuildContext context) {
    traverse = Provider.of<ModuleTraverse>(context);
    String text = (widget.modNum == 12) ? "Oh Yes!" : "Start";
    return PageView(
      children: <Widget>[
        Container(
            color: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                StreamBuilder(
                    stream: db
                        .collection('module')
                        .where("id", "==", widget.modNum)
                        .onSnapshot,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01,
                          right: MediaQuery.of(context).size.width * 0.01,
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Material(
                                  color: Colors.black.withOpacity(0),
                                  child: Text(
                                    snapshot.data.docs[0].data()['quote'][0],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      // fontStyle: FontStyle.italic,
                                      letterSpacing: 1.5,
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.black.withOpacity(0),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                    child: Text(
                                      snapshot.data.docs[0].data()['quote'][1],
                                      style: TextStyle(
                                          letterSpacing: 1.5,
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.4,
                      left: MediaQuery.of(context).size.width * 0.64),
                  child: FlatButton(
                    child: Row(
                      children: <Widget>[
                        Text(
                          text,
                          style: TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 20,
                            color: Colors.white,
                            // fontWeight: FontWeight.w700
                          ),
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                          size: 40,
                        ),
                      ],
                    ),
                    onPressed: () {
                      if (widget.modNum != 12) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ModuleOverviewLoading(modNum: widget.modNum),
                            // builder: (context)=>Vocabulary(),
                          ),
                        );
                      } else {
                        // orderManagement.moveNextIndex(context, [12, 24]);
                        traverse.navigate();
                      }
                    },
                  ),
                )
              ],
            )),
      ],
      // ),
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.end,
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Material(
              color: Colors.black.withOpacity(0),
              child: Text(
                widget.quote[0],
                textAlign: TextAlign.center,
                style: TextStyle(
                  // fontStyle: FontStyle.italic,
                  letterSpacing: 1.5,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            Material(
              color: Colors.black.withOpacity(0),
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                child: Text(
                  widget.quote[1],
                  style: TextStyle(
                      letterSpacing: 1.5,
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
