import 'package:after_layout/after_layout.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:provider/provider.dart';
import 'package:startupreneur/HustleStore/HustleStoreLoader.dart';
import 'package:startupreneur/ModulePages/ModuleOverview/ModuleOverviewLoading.dart';
import 'package:startupreneur/ModulePages/Quote/quoteLoading.dart';
import 'package:startupreneur/ModulePages/special_activities/bmc.dart';
import 'package:startupreneur/VentureBuilder/TabUI/custom_timeline.dart';
import 'package:startupreneur/VentureBuilder/TabUI/module_controller.dart';
import 'package:startupreneur/VentureBuilder/UserInterface/ListActivity.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:startupreneur/customWidgets/RaisedButtonGradient.dart';
import 'package:startupreneur/saveProgress.dart';
import 'package:startupreneur/timeline/MainRoadmap.dart';
import 'package:startupreneur/timeline/data.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:startupreneur/ModuleOrderController/Types.dart';

class ActivityController extends StatefulWidget {
  ActivityController(
      {Key key,
      this.modNum,
      this.modName,
      this.intro,
      this.headings,
      this.index,
      this.files,
      this.order,
      this.buttons,
      this.textBox,
      this.suggestion,
      this.tableView})
      : super(key: key);
  int modNum, index, order;
  String modName, files;
  List intro, headings, buttons, textBox, suggestion, tableView;
  @override
  _ActivityControllerState createState() => _ActivityControllerState();
}

class _ActivityControllerState extends State<ActivityController>
    with AfterLayoutMixin<ActivityController> {
  fs.Firestore db = fb.firestore();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback(() => showGeneralDialog(
    //     context: context,
    //     barrierDismissible: true,
    //     barrierLabel:
    //         MaterialLocalizations.of(context).modalBarrierDismissLabel,
    //     barrierColor: Colors.black45,
    //     transitionDuration: const Duration(milliseconds: 200),
    //     pageBuilder: (BuildContext buildContext, Animation animation,
    //         Animation secondaryAnimation) {
    //       return Center(
    //         child: Container(
    //           width: MediaQuery.of(context).size.width - 10,
    //           height: MediaQuery.of(context).size.height - 80,
    //           padding: EdgeInsets.all(20),
    //           color: Colors.white,
    //           child: Column(
    //             children: [
    //               RaisedButton(
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: Text(
    //                   "Save",
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //                 color: const Color(0xFF1BC0C5),
    //               )
    //             ],
    //           ),
    //         ),
    //       );
    //     }));
    double ratio = 0.3;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/Images/Capture.PNG",
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 8.0,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: ChangeNotifierProvider<ActivityChangeNotifier>(
            create: (context) => ActivityChangeNotifier(
              modnum: widget.modNum,
              order: widget.index,
              intro: widget.intro,
              headings: widget.headings,
              modName: widget.modName,
              files: widget.files,
              buttons: widget.buttons,
              textBox: widget.textBox,
              suggestion: widget.suggestion,
              moduleOrderNo: widget.order,
              tableView: widget.tableView,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: size.width * 0.7,
                  height: size.height,
                  child: Container(
                    height: size.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Consumer<ActivityChangeNotifier>(
                        //   builder: (context, activity, _) {
                        //     return Container(
                        //       padding: EdgeInsets.only(top: 5),
                        //       height: size.height * 0.08,
                        //       child: CustomTimeLine(
                        //         doodle: doodles[activity.modnum - 1].doodle,
                        //         direction: Axis.horizontal,
                        //         itemCount: moduleOrder.length,
                        //         completeIndex:
                        //             moduleOrder.indexOf(activity.modnum),
                        //         builder: (context, i) {
                        //           return Material(
                        //             color: Colors.white,
                        //             child: Container(
                        //               child: Text("${doodles[i].modName}"),
                        //             ),
                        //           );
                        //         },
                        //       ),
                        //     );
                        //   },
                        // ),
                        Card(
                          elevation: 8.0,
                          child: Container(
                            height: size.height * 0.93,
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Consumer<ActivityChangeNotifier>(
                                    builder: (context, activity, _) {
                                      print(
                                          "activity.modnum ${activity.toString()}");
                                      return StreamBuilder<Object>(
                                          stream: db
                                              .collection("activity")
                                              .where("module", "==",
                                                  activity.modnum)
                                              .onSnapshot,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              activity
                                                  .updateIntros(snapshot.data);
                                              return activity.activityWidget();
                                            } else {
                                              return Center(
                                                child: Container(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              );
                                            }
                                          });
                                    },
                                  ),
                                ),
                                Consumer<ActivityChangeNotifier>(
                                    builder: (context, activity, _) {
                                  return Align(
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        RaisedGradientButton(
                                          width: 200,
                                          height: 50,
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.green,
                                              Color(0xFF30B8AA),
                                            ],
                                          ),
                                          onPressed: () {
                                            activity.decreaseOrder();
                                          },
                                          child: Text(
                                            "Previous Module Activity",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        RaisedGradientButton(
                                          width: 200,
                                          height: 50,
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.green,
                                              Color(0xFF30B8AA),
                                            ],
                                          ),
                                          onPressed: () {
                                            activity.moveNext();
                                          },
                                          child: Text(
                                            "Next Module Activity",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //   ),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Consumer<ActivityChangeNotifier>(
                  builder: (context, activity, _) {
                    print(
                        "activity.modnum is //////////////////////////////////////////////////////////////////////////////////////////// ${activity.modnum}");
                    ModuleTraverse moduleTraverse =
                        ModuleTraverse(modnum: activity.modnum, order: -1);
                    return Card(
                      elevation: 8.0,
                      child: Container(
                        width: size.width * 0.27,
                        height: MediaQuery.of(context).size.height * 0.99,
                        // color: Colors.red,
                        child: ChangeNotifierProvider<ModuleTraverse>(
                          create: (_) => moduleTraverse,
                          // ModuleTraverse(modnum: activity.modnum, order: 0),
                          child: Consumer<ModuleTraverse>(
                            builder: (context, traverse, _) {
                              traverse.updateModNum(activity.modnum);
                              print(
                                  "activity.modnum is ********************************************************************************************************** ${traverse.modnum}");
                              return traverse.order < 0
                                  ? centerTimeline(context,
                                      moduleOrder.indexOf(activity.modnum))
                                  : traverse.nextPage();
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget centerTimeline(BuildContext context, int i) {
    var doodle = doodles[i];
    return GestureDetector(
      onTap: () {
        print(" true ${doodle.modNum}");
        Provider.of<ModuleTraverse>(context, listen: false).navigate();
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: Align(
              alignment: Alignment.topCenter,
              child: AutoSizeText(
                "What will you learn in this Module",
                style: TextStyle(
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
                minFontSize: 18,
                maxFontSize: 24,
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: Colors.grey[50],
                // width: MediaQuery.of(context).size.width*0.5,
                // height: MediaQuery.of(context).size.height*0.5,
                height: 220.0,
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
                          height: MediaQuery.of(context).size.height * 0.1,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Colors.green,
                            textColor: Colors.black,
                            // hoverColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                color: Colors.green,
                                width: 2,
                              )
                            ),
                            onPressed: (){
                              Provider.of<ModuleTraverse>(context, listen: false).navigate();
                            },
                            child: Text("Start"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //                )
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.55,left: MediaQuery.of(context).size.height * 0.01,right: MediaQuery.of(context).size.height * 0.01,bottom: MediaQuery.of(context).size.height*0.01),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                color: Colors.grey[50],
                // width: MediaQuery.of(context).size.width * 0.5,
                // height: MediaQuery.of(context).size.height * 0.5,
                child: GradientCard(
                  margin: EdgeInsets.all(0),
                  gradient: LinearGradient(colors: doodle.colors),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Colors.green,
                        width: 2,
                      )),
                  child: Padding(
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04,left: 10,right: 10,bottom: 20),
                    child: AutoSizeText(
                      "${doodle.modDec}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w400,
                      ),
                      minFontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout

    showDialogHolder(context);
  }
}

void showDialogHolder(BuildContext context) {
  showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Material(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.4,
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Welcome to Venture Builder",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Text(
                    "This is your Activity Screen which will involve you undertaking a series of exciting and practical activities. You can have a look at the module theory and explanation on the right side of this platform.\n\nYou will learn in-depth strategies, exciting case studies, tips and tricks about each module as you look through the theory.\n\nGo ahead! continue your Startupreneur Journey!",
                    //     .replaceAll(
                    //   ".  ",
                    //   "\n",

                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: const Color(0xFF1BC0C5),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

class ActivityChangeNotifier with ChangeNotifier {
  int modnum, order, noOfActivity, moduleOrderNo;
  String modName, files, special;

  ActivityChangeNotifier({
    this.modnum,
    this.order,
    this.headings,
    this.intro,
    this.modName,
    this.files,
    this.buttons,
    this.moduleOrderNo,
    this.textBox,
    this.suggestion,
    this.tableView,
  });

  List intro = [];
  List headings = [];
  List buttons = [];
  List textBox = [];
  List suggestion = [];
  List tableView = [];

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
    print("updateIntros ${snapshot.docs} ");
    noOfActivity = snapshot.docs.length;

    print(snapshot.docs[order].data()['buttons']);

    headings.clear();
    intro.clear();
    buttons.clear();
    textBox.clear();
    suggestion.clear();
    tableView.clear();

    print("snapshot.docs.length ${snapshot.docs[order].data()}");
    print("Entering Page");
    snapshot.docs[order].data()['Page'].forEach((value) {
      headings.add(value);
    });
    print("Entering content");

    snapshot.docs[order].data()['content'].forEach((value) {
      intro.add(value);
      // print("object $value");
    });
    print("Entering buttons");

    snapshot.docs[order].data()['buttons'].forEach((value) {
      buttons.add(value);
    });
    snapshot.docs[order].data()['textBox'].forEach((value) {
      textBox.add(value);
    });
    snapshot.docs[order].data()['suggestion'].forEach((value) {
      suggestion.add(value);
    });
    snapshot.docs[order].data()['tableView'].forEach((value) {
      tableView.add(value);
    });

    files = snapshot.docs[order].data()['file'];
    moduleOrderNo = snapshot.docs[order].data()['order'];
    special = snapshot.docs[order].data()['special'];
    print("After chaging $special");
  }

  @override
  String toString() {
    return "modunenum $modnum modname $modName  modorderNo $moduleOrderNo order $order";
  }

  Widget activityWidget() {
    print("ACTIVITY ************************* special =  $special");
    if (special.toLowerCase().compareTo("bussiness model canvas") == 0) {
      return BusinessModelCanvas(
        title: "Bussiness Model Canvas",
        index: order,
      );
    }

    return ListActivities(
        modName: this.modName,
        modNum: this.modnum,
        intro: this.intro,
        headings: this.headings,
        index: this.order,
        files: this.files,
        buttons: this.buttons,
        btnLength: this.buttons.length,
        order: this.moduleOrderNo,
        textBox: this.textBox,
        suggestion: this.suggestion,
        tableView: this.tableView);
  }
}
