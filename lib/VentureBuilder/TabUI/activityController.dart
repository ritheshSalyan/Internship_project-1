import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:provider/provider.dart';
import 'package:startupreneur/HustleStore/HustleStoreLoader.dart';
import 'package:startupreneur/ModulePages/ModuleOverview/ModuleOverviewLoading.dart';
import 'package:startupreneur/ModulePages/Quote/quoteLoading.dart';
import 'package:startupreneur/VentureBuilder/TabUI/custom_timeline.dart';
import 'package:startupreneur/VentureBuilder/UserInterface/ListActivity.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:startupreneur/saveProgress.dart';
import 'package:startupreneur/timeline/MainRoadmap.dart';
import 'package:startupreneur/timeline/data.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:startupreneur/ModuleOrderController/Types.dart';

class ActivityController extends StatefulWidget {
  ActivityController({
    Key key,
    this.modNum,
    this.modName,
    this.intro,
    this.headings,
    this.index,
    this.files,
    this.order,
  }) : super(key: key);
  int modNum, index, order;
  String modName, files;
  List intro, headings;
  @override
  _ActivityControllerState createState() => _ActivityControllerState();
}

class _ActivityControllerState extends State<ActivityController> {
  fs.Firestore db = fb.firestore();
  @override
  Widget build(BuildContext context) {
    double ratio = 0.3;
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<ActivityChangeNotifier>(
        create: (context) => ActivityChangeNotifier(
            modnum: widget.modNum,
            order: widget.index,
            intro: widget.intro,
            headings: widget.headings,
            modName: widget.modName,
            files: widget.files,
            moduleOrderNo: widget.order),
        child: Row(children: <Widget>[
          Container(
            width: size.width * (1 - ratio),
            height: size.height,
            child: Container(
              height: size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Consumer<ActivityChangeNotifier>(
                      builder: (context, activity, _) {
                    return Container(
                      height: size.height * 0.1,
                      child: CustomTimeLine(
                        direction: Axis.horizontal,
                        itemCount: moduleOrder.length,
                        completeIndex: moduleOrder.indexOf(activity.modnum),
                        builder: (context, i) {
                          return Container();
                        },
                      ),
                    );
                  }),
                  Container(
                    height: size.height * 0.9,
                    child: Stack(
                      children: <Widget>[
                        Consumer<ActivityChangeNotifier>(
                          builder: (context, activity, _) {
                            print("activity.modnum ${activity.toString()}");
                            return StreamBuilder<Object>(
                                stream: db
                                    .collection("activity")
                                    .where("module", "==", activity.modnum)
                                    .onSnapshot,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    activity.updateIntros(snapshot.data);
                                    return ListActivities(
                                        modName: activity.modName,
                                        modNum: activity.modnum,
                                        intro: activity.intro,
                                        headings: activity.headings,
                                        index: activity.order,
                                        files: activity.files,
                                        order: activity.moduleOrderNo);
                                  } else {
                                    return Center(
                                      child: Container(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                });
                          },
                        ),
                        Consumer<ActivityChangeNotifier>(
                            builder: (context, activity, _) {
                          return Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                OutlineButton(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                  onPressed: () {
                                    activity.decreaseOrder();
                                  },
                                  child: Text(
                                    "Previous Activity",
                                  ),
                                ),
                                OutlineButton(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                  onPressed: () {
                                    activity.moveNext();
                                  },
                                  child: Text(
                                    "Next Activity",
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //   ),
          ),
          Consumer<ActivityChangeNotifier>(
            builder: (context, activity, _) {
              return Container(
                width: size.width * ratio,
                color: Colors.red,
                child: centerTimeline(
                    context, moduleOrder.indexOf(activity.modnum)),
              );
            },
          ),
        ]));
  }

  Widget centerTimeline(BuildContext context, int i) {
    var doodle = doodles[i];
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                print(" true ${doodle.modNum}");
                // if (progressNum == 0) {
                if (doodle.modNum == 12 || doodle.modNum == 14) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ModuleOverviewLoading(modNum: doodle.modNum),
                    ),
                  );
                } else if (doodle.modNum != 12) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QuoteLoading(modNum: doodle.modNum),
                    ),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => (HustleStoreLoader()),
                    ),
                  );
                }
              },
              // else {
              //   showDialog<bool>(
              //       context: context,
              //       builder: (_) {
              //         return AlertDialog(
              //           content: Text("Do you want to resume this Module?"),
              //           title: Text(
              //             "Continue",
              //           ),
              //           actions: <Widget>[
              //             FlatButton(
              //               child: Text(
              //                 "Yes",
              //                 style: TextStyle(color: Colors.green),
              //               ),
              //               onPressed: () {
              //                 Navigator.of(context).pop(true);
              //                 // Navigator.of(context).popUntil(ModalRoute.withName("/QuoteLoading"));
              //                 SaveProgress.getEventsFromFirestore(
              //                         doodle.modNum)
              //                     .then((_) {
              //                   List<int> arguments = [
              //                     doodle.modNum,
              //                     progressNum
              //                   ];
              //                   orderManagement.moveNextIndex(
              //                       context, arguments);
              //                 });
              //               },
              //             ),
              //             FlatButton(
              //               child: Text(
              //                 "No",
              //                 style: TextStyle(color: Colors.red),
              //               ),
              //               onPressed: () {
              //                 Navigator.of(context).pop(true);
              //                 if (doodle.modNum == 11 ||
              //                     doodle.modNum == 14) {
              //                   Navigator.of(context).push(
              //                     MaterialPageRoute(
              //                       builder: (context) =>
              //                           ModuleOverviewLoading(
              //                               modNum: doodle.modNum),
              //                     ),
              //                   );
              //                 } else if (doodle.modNum != 12) {
              //                   Navigator.of(context).push(
              //                     MaterialPageRoute(
              //                       builder: (context) =>
              //                           QuoteLoading(modNum: doodle.modNum),
              //                     ),
              //                   );
              //                 } else {
              //                   Navigator.of(context).push(
              //                     MaterialPageRoute(
              //                       builder: (context) =>
              //                           (HustleStoreLoader()),
              //                     ),
              //                   );
              //                 }
              //               },
              //             ),
              //           ],
              //         );
              //       });
              // }
              // },
              child: Container(
                color: Colors.grey[50],
                height: 210.0,
                width: 145.0,
                child: GradientCard(
                  gradient: LinearGradient(colors: doodle.colors),
                  //                    color: doodle.color,
                  margin: EdgeInsets.all(0),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.green,
                      // width: 3,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // shape:Border.all(width: 3,
                  // color: Colors.green),
                  // margin: EdgeInsets.symmetric(vertical: 16.0),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Image.network(doodle.doodle),
                        Image.asset(
                          doodle.doodle,
                          height: MediaQuery.of(context).size.height * 0.09,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        doodle.name,
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            doodle.pointsIcon,
                            Text(" "),
                            doodle.points,
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //                )
              ),
            ),
          ],
        ),
      ),
    );
    // return TimelineModel(
    //       new GestureDetector(
    //         onTap: () async {
    //           print("value of i is $i");
    //           // if (check(doodle.modNum)) {
    //             print(" true ${doodle.modNum}");
    //             // val = completedCourse[k];
    //             // print("val is $val");
    //             int progressNum = await SaveProgress.getProgerss(doodle.modNum);
    //             print("PROGRESS NUM $progressNum");
    //             if (progressNum == 0) {
    //               if (doodle.modNum == 12 || doodle.modNum == 14) {
    //                 Navigator.of(context).push(
    //                   MaterialPageRoute(
    //                     builder: (context) =>
    //                         ModuleOverviewLoading(modNum: doodle.modNum),
    //                   ),
    //                 );
    //               } else if (doodle.modNum != 12) {
    //                 Navigator.of(context).push(
    //                   MaterialPageRoute(
    //                     builder: (context) => QuoteLoading(modNum: doodle.modNum),
    //                   ),
    //                 );
    //               } else {
    //                 Navigator.of(context).push(
    //                   MaterialPageRoute(
    //                     builder: (context) => (HustleStoreLoader()),
    //                   ),
    //                 );
    //               }
    //             } else {
    //               showDialog<bool>(
    //                   context: context,
    //                   builder: (_) {
    //                     return AlertDialog(
    //                       content: Text("Do you want to resume this Module?"),
    //                       title: Text(
    //                         "Continue",
    //                       ),
    //                       actions: <Widget>[
    //                         FlatButton(
    //                           child: Text(
    //                             "Yes",
    //                             style: TextStyle(color: Colors.green),
    //                           ),
    //                           onPressed: () {
    //                             Navigator.of(context).pop(true);
    //                             // Navigator.of(context).popUntil(ModalRoute.withName("/QuoteLoading"));
    //                             SaveProgress.getEventsFromFirestore(doodle.modNum)
    //                                 .then((_) {
    //                               List<int> arguments = [
    //                                 doodle.modNum,
    //                                 progressNum
    //                               ];
    //                               orderManagement.moveNextIndex(
    //                                   context, arguments);
    //                             });
    //                           },
    //                         ),
    //                         FlatButton(
    //                           child: Text(
    //                             "No",
    //                             style: TextStyle(color: Colors.red),
    //                           ),
    //                           onPressed: () {
    //                             Navigator.of(context).pop(true);
    //                             if (doodle.modNum == 11 || doodle.modNum == 14) {
    //                               Navigator.of(context).push(
    //                                 MaterialPageRoute(
    //                                   builder: (context) => ModuleOverviewLoading(
    //                                       modNum: doodle.modNum),
    //                                 ),
    //                               );
    //                             } else if (doodle.modNum != 12) {
    //                               Navigator.of(context).push(
    //                                 MaterialPageRoute(
    //                                   builder: (context) =>
    //                                       QuoteLoading(modNum: doodle.modNum),
    //                                 ),
    //                               );
    //                             } else {
    //                               Navigator.of(context).push(
    //                                 MaterialPageRoute(
    //                                   builder: (context) => (HustleStoreLoader()),
    //                                 ),
    //                               );
    //                             }
    //                           },
    //                         ),
    //                       ],
    //                     );
    //                   });
    //             }
    //           // } else {
    //           //   print(" false");
    //           // }
    //         },
    //         child: Stack(
    //           alignment: Alignment.center,
    //           children: <Widget>[
    //             Container(
    //               color: Colors.grey[50],
    //               height: 210.0,
    //               width: 145.0,
    //               child: GradientCard(
    //                 gradient: LinearGradient(colors: doodle.colors),
    //                 //                    color: doodle.color,
    //                 margin: EdgeInsets.all(0),
    //                 elevation: 10,
    //                 shape: RoundedRectangleBorder(
    //                   side: BorderSide(
    //                     color: Colors.green,
    //                     // width: 3,
    //                     width: 2,
    //                   ),
    //                   borderRadius: BorderRadius.circular(12),
    //                 ),
    //                 // shape:Border.all(width: 3,
    //                 // color: Colors.green),
    //                 // margin: EdgeInsets.symmetric(vertical: 16.0),
    //                 clipBehavior: Clip.antiAlias,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(16.0),
    //                   child: Column(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: <Widget>[
    //                       // Image.network(doodle.doodle),
    //                       Image.asset(
    //                         doodle.doodle,
    //                         height: MediaQuery.of(context).size.height * 0.09,
    //                       ),
    //                       const SizedBox(
    //                         height: 8.0,
    //                       ),
    //                       doodle.name,
    //                       const SizedBox(
    //                         height: 8.0,
    //                       ),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: <Widget>[
    //                           doodle.pointsIcon,
    //                           Text(" "),
    //                           doodle.points,
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               //                )
    //             ),

    //           ],
    //         ),
    //       ),
    //       position:
    //           i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
    //       isFirst: i == 0,
    //       isLast: i == doodles.length,
    //       iconBackground: doodle.iconBackground,
    //       icon: doodle.icon);
  }
}

class ActivityChangeNotifier with ChangeNotifier {
  int modnum, order, noOfActivity, moduleOrderNo;
  String modName, files;
  List intro = [];
  List headings = [];

  ActivityChangeNotifier(
      {this.modnum,
      this.order,
      this.headings,
      this.intro,
      this.modName,
      this.files,
      this.moduleOrderNo});

  void changeModule() {
    int modindex = moduleOrder.indexOf(modnum);

    modnum =
        moduleOrder[modindex < moduleOrder.length ? modindex + 1 : modindex];

    updateModname(modnum);
    order = 0;
    notifyListeners();
  }

  void changeOrder() {
    if (order < noOfActivity) order++;
    notifyListeners();
  }

  void moveNext() {
    if (order < noOfActivity - 1) {
      changeOrder();
    } else {
      changeModule();
    }
  }

  void decreaseOrder() {
    if (order < 0)
      order--;
    else
      decreaseModule();
    print("Notify Listners");
    notifyListeners();
  }

  void decreaseModule() {
    print("Starung of decreaseModule $modnum  $order $modName");
    int modindex = moduleOrder.indexOf(modnum);
    print("Mod index is $modindex");
    modnum = moduleOrder[modindex > 0 ? modindex - 1 : modindex];
    if (modnum == 1) modnum = 2;

    order = 0;
    updateModname(modnum);
    print("ending of decreaseModule $modnum  $order $modName");
  }

  void updateModname(int mod) {
    int index = doodles.indexWhere((dood) => dood.modNum == mod);
    modName = doodles[index].modName;
  }

  void updateIntros(fs.QuerySnapshot snapshot) {
    print("updateIntros $order  $modnum ");
    noOfActivity = snapshot.docs.length;
    print(snapshot.docs[order].data()['Page']);
    headings.clear();
    intro.clear();
    print("snapshot.docs.length ${snapshot.docs.length}");
    snapshot.docs[order].data()['Page'].forEach((value) {
      headings.add(value);
    });
    snapshot.docs[order].data()['content'].forEach((value) {
      intro.add(value);
      // print("object $value");
    });

    files = snapshot.docs[order].data()['file'];
    moduleOrderNo = snapshot.docs[order].data()['order'];
  }

  @override
  String toString() {
    return "modunenum $modnum modname $modName  modorderNo $moduleOrderNo order $order";
  }
}
