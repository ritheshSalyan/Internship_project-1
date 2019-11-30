import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:startupreneur/NoInternetPage/NoNetPage.dart';
import '../../ModuleOrderController/Types.dart';

class FlipPage extends StatefulWidget {
  FlipPage({Key key, this.modnum, this.index}) : super(key: key);
  int modnum, index;
  @override
  _FlipPageState createState() => _FlipPageState();
}

class _FlipPageState extends State<FlipPage> {
  static Future<List<String>> getEventsFromFirestore(
      int modNum, int index) async {
    CollectionReference ref = Firestore.instance.collection('flipPage');
    QuerySnapshot eventsQuery = await ref
        .where("module", isEqualTo: modNum)
        .where("order", isEqualTo: index)
        .getDocuments();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
    List<String> title = [];
    eventsQuery.documents.forEach((document) {
      print("ImagePage " + document.toString());

      title = convert(document["content"]);
      // title.add(document["image"].toString());
    });

    return title;
  }

  static List<String> convert(List<dynamic> dlist) {
    List<String> list = new List<String>();

    for (var item in dlist) {
      list.add(item.toString());
      print(item.toString());
    }
    //list.add("assets/Images/think.png");
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder:
          (context, ConnectivityResult connectivity, Widget child) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          child = Scaffold(
            bottomSheet: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "${widget.index + 1}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
            body: StreamBuilder(
              stream: getEventsFromFirestore(widget.modnum, widget.index)
                  .asStream(),
              builder: (contex, data) {
                if (data.hasData) {
                  return Material(
                    child: Center(
                      child: FlipCard(
                        direction: FlipDirection.HORIZONTAL, // default
                        front: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.green,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // textBaseline: TextBaseline.alphabetic,
                              // verticalDirection: VerticalDirection.up,
                              children: <Widget>[
                                // Padding(
                                //   padding: EdgeInsets.only(
                                //       top: MediaQuery.of(context).size.height * 0.4),
                                // child:
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "${data.data[0]}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                    ),
                                    Text(
                                      "Tap Here to flip and look at the answer !",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),

                                // ),
                                // Padding(
                                //   padding: EdgeInsets.only(
                                //       top: MediaQuery.of(context).size.height * 0.3),
                                //   child:

                                // ),
                              ],
                            ),
                          ),
                        ),

                        back: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "${data.data[1]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    // ),
                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //     top: MediaQuery.of(context).size.height * 0.05,
                                    //     // left: MediaQuery.of(context).size.width *0.5,
                                    //   ),
                                    // child:
                                    OutlineButton(
                                      borderSide:
                                          BorderSide(color: Colors.green),
                                      onPressed: () {
                                        List<dynamic> arguments = [
                                          widget.modnum,
                                          widget.index + 1
                                        ];
                                        orderManagement.moveNextIndex(
                                            context, arguments);
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Continue",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Icon(
                                              Icons.navigate_next,
                                              color: Colors.green,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          );
        }
        return child;
      },
      child: NoNetPage(),
    );
  }
}
