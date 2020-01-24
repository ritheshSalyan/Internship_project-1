import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:startupreneur/HelpandFAQ/helpAndFaq.dart';

import 'package:startupreneur/Mentorfeedback/mentorFeedback.dart';
import 'package:startupreneur/ModulePages/ModuleOverview/ModuleOverviewLoading.dart';
import 'package:startupreneur/ModulePages/Quote/quoteLoading.dart';
import 'package:startupreneur/VentureBuilder/TabUI/activityController.dart';
import 'package:startupreneur/VentureBuilder/TabUI/activityList.dart';
import 'package:startupreneur/VentureBuilder/TabUI/module_controller.dart';
import 'package:startupreneur/VentureBuilder/UserInterface/folderUI.dart';
import 'package:startupreneur/additionalMaterial/additionalMaterial.dart';

import 'package:startupreneur/models/notificationModel.dart';
import 'package:startupreneur/saveProgress.dart';
import 'package:toast/toast.dart';
import '../GeneralVocabulary/GeneralVocabulary.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import '../globalKeys.dart';
import 'data.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:startupreneur/HustleStore/HustleStoreLoader.dart';
import '../Auth/signin.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase/firebase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ChatBoardRoom/ChatBoardRoomLoader.dart';
import '../ModuleOrderController/Types.dart';
import 'package:url_launcher/url_launcher.dart';
import '../ProfilePage/ProfilePageLoader.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'notifications.dart';

class TimelinePage extends StatefulWidget {
  TimelinePage({Key key, this.title, this.userEmail, this.status})
      : super(key: key);
  final String title;
  final String userEmail;
  bool status;

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  // Auth _auth = fb.auth();
  fs.Firestore db = fb.firestore();
  SharedPreferences sharedPreferences;
  int gems = 0;
  VideoPlayerController controller;
  BuildContext context;
  List<int> completedCourse = [];
  // FirebaseUser user;
  String value = "";
  String uid = "";
  // static var date;
  bool position = true;
  var val = 1;
  bool timeSet = false;
  static String name = "User";
  PDFDocument doc;
  Flushbar<List<String>> flush;
  FirebaseMessaging _messaging = FirebaseMessaging();
  double contentRating = 0;
  double structureRating = 0;
  double experinceRating = 0;
  String commentText;
  String institution;
  ModuleTraverse traverse = ModuleTraverse();
  // final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  String _url =
      "https://firebasestorage.googleapis.com/v0/b/thestartupreneur-e1201.appspot.com/o/images%2Favatar.png?alt=media&token=d6c06033-ba6d-40f9-992c-b97df1899102";

  Widget lockUnlock(int i, List<int> id) {
    final doodle = doodles[i];
    // for (var k = 0; k < id.length; k++) {
    //   if (doodle.time == "Module ${id[k]}") {
    return Icon(
      Icons.lock_open,
      size: 0.0,
    );
    //   }
    // }
    // return Padding(
    //   padding: EdgeInsets.only(top: 120),
    //   child: Icon(
    //     Icons.lock,
    //     size: 20,
    //   ),
    // );
  }

  void _sharedpreference(BuildContext context) async {
    sharedPreferences = await SharedPreferences.getInstance();
    var docId = sharedPreferences.getString("docId");
    print("docId is $docId");
    sharedPreferences.clear();
    await db
        .collection("user")
        .doc(docId)
        .set({"isLoggedIn": false}, fs.SetOptions(merge: true));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => SigninPage(),
    ));
  }

  Future<void> _sendFeedback() async {
    Map<String, dynamic> data = {
      "feedbackContent": commentText,
      "contentRating": contentRating,
      "structureRating": structureRating,
      "experinceRating": experinceRating,
      "userId": uid,
      "institution": institution,
      "userName": name
    };
    await db.collection("internalAppFeedback").add(data);
  }

  launcher(String urlLink) async {
    String url = urlLink;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void initState() {
    super.initState();
    Global.date = DateTime.now().millisecondsSinceEpoch;
    print(Global.date);
    preferences(context);
    print("inside main roadmap");
  }

  navigateTo(BuildContext context, var message) {
    print("on navigate $message");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MentorFeedback(
          uid: uid,
        ),
      ),
    );
  }

  ActivityChangeNotifier activity;

  void preferences(BuildContext context) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      value = sharedPreferences.getString("UserEmail");
      uid = sharedPreferences.getString("UserId");
      institution = sharedPreferences.getString("institution");
    });
    print("the value is $value");
    if (value == null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => SigninPage(),
      ));
    }
    await db.collection("user").where("uid", "==", uid).get().then((document) {
      document.docs.forEach((value) {
        setState(() {
          gems = value.data()["points"];
          name = value.data()["name"];
          _url = value.data()["profile"];
        });
      });
    });

    print("userid from main roadmap is $uid");

    await db.collection("user").where("uid", "==", uid).get().then((document) {
      document.docs.forEach((value) {
        for (int i in value.data()["completed"]) {
          setState(() {
            print("done");
            completedCourse.add(i);
          });
        }
      });
    });
  }

  bool check(int i) {
    print("Completed course" + completedCourse.toString());
    // for (int k = 0; k < completedCourse.length; k++) {
    //   if (completedCourse[k] == i + 1) {
    //     val = completedCourse[k];
    //     return true;
    //   }
    // }
    if (completedCourse.contains(i)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // _fcm.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     // TODO optional
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     navigateTo(context, message);
    //     // TODO optional
    //   },
    // );
    // print("context is from build $context");
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (widget.status) {
    //     Flushbar(
    //       titleText: Text(
    //         "Welcome to Startupreneur",
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //           color: Colors.white,
    //           fontSize: 18,
    //         ),
    //       ),
    //       backgroundColor: Colors.green,
    //       messageText: Column(
    //         children: <Widget>[
    //           RichText(
    //             text: TextSpan(children: [
    //               TextSpan(
    //                 text: "Congratulations! You have received",
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 16,
    //                 ),
    //               ),
    //               TextSpan(
    //                 text: " 1000 ",
    //                 style: TextStyle(
    //                   color: Colors.yellow,
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.w900,
    //                 ),
    //               ),
    //               TextSpan(
    //                 text: "points as a registration bonus :) \n Keep Learning!",
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 16,
    //                 ),
    //               ),
    //             ]),
    //           ),
    //           OutlineButton(
    //             color: Colors.black,
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(20),
    //             ),
    //             child: Text(
    //               "Yay!",
    //               style: TextStyle(
    //                 color: Colors.white,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       // duration: Duration(seconds: 5),
    //     )..show(context);
    //     setState(() {
    //       widget.status = false;
    //     });
    //   }
    // });
    List<Widget> pages = [
      timelineModel(TimelinePosition.Center),
    ];
    activity = ActivityChangeNotifier();
    orderManagement.currentIndex = 0;
    ModuleTraverse moduleTraverse =
        ModuleTraverse(modnum: activity.modnum, order: 0);

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Padding(
          padding: const EdgeInsets.all(9.5),
          child: Center(
            child: Image.asset(
              "assets/Images/Capture.PNG",
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).primaryColorDark,
        elevation: 10.0,
        actions: <Widget>[
          StreamBuilder(
              stream: db
                  .collection('notification')
                  .where("timestamp", ">=", Global.date)
                  .orderBy("timestamp")
                  .onSnapshot,
              builder: (context, snapshot) {
                print(snapshot.hasData);
                if (snapshot.hasData) {
                  List<NotificationModel> notify = [];
                  return Stack(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          snapshot.data.docs.forEach(
                            (data) {
                              notify.add(
                                NotificationModel(
                                  msg: data.data()['msg'],
                                  timestamp: data.data()['timestamp'],
                                  type: data.data()['type'],
                                ),
                              );
                            },
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationDetail(
                                listData: notify,
                                uid: uid,
                              ),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.green,
                        ),
                      ),
                      new Positioned(
                        right: 11,
                        top: 11,
                        child: new Container(
                          padding: EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: Text(
                            '${snapshot.data.docs.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Stack(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.green,
                      ),
                    ),
                    new Positioned(
                      right: 11,
                      top: 11,
                      child: new Container(
                        padding: EdgeInsets.all(2),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          '0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                );
              }),

          // Row(
          //   children: <Widget>[
          //     Image.asset(
          //       "assets/Images/coins.png",
          //       height: 15,
          //       width: 15,
          //     ),
          //     Text(
          //       " $gems",
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontSize: 12,
          //       ),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.only(right: 20),
          //     ),
          //   ],
          // )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Row(
                children: <Widget>[
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     FontAwesomeIcons.solidGem,
                  //     color: Colors.green,
                  //     size: 15,
                  //   ),
                  // ),
                  GestureDetector(
                    child: Image.asset(
                      "assets/Images/coins.png",
                      height: 20,
                      width: 20,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileLoading(uid: uid),
                        ),
                      );
                    },
                  ),
                  Text(
                    " $gems",
                    style: TextStyle(color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                  ),
                ],
              ),
              accountName: Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(_url),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileLoading(uid: uid),
                    ),
                  );
                },
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: <Widget>[
                    Image.asset("assets/Images/log.png"),
                  ],
                )),
            ListTile(
              leading: Icon(
                Icons.assignment_ind,
              ),
              title: Text(
                'My Dashboard',
                style: TextStyle(
                  letterSpacing: 0.5,
                  color: Colors.green,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileLoading(uid: uid),
                  ),
                );
              },
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.book,
            //   ),
            //   title: Text(
            //     'Startup Dictionary',
            //     style: TextStyle(
            //       letterSpacing: 0.5,
            //       color: Colors.green,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => (Vocabulary()),
            //       ),
            //     );
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.store),
            //   title: Text(
            //     'The Startupreneur GoldMine',
            //     style: TextStyle(
            //       color: Colors.green,
            //       letterSpacing: 0.5,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => (HustleStoreLoader()),
            //       ),
            //     );
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text(
                'Discussion Board',
                style: TextStyle(
                  letterSpacing: 0.5,
                  color: Colors.green,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => (ChatBoardRoomLoader()),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.business_center),
              title: Text(
                'Venture Builder',
                style: TextStyle(
                  letterSpacing: 0.5,
                  color: Colors.green,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ActivityController(
                      modName: "Idea",
                      modNum: 2,
                      intro: [""],
                      index: -1,
                      headings: [""],
                      files: "",
                      order: 0,
                      buttons: [""],
                      textBox: [""],
                      suggestion: [""],
                      tableView: [''],
                    ), //FolderBuilder(completedCourse: completedCourse)),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.folder),
              title: Text(
                'Additional Materials',
                style: TextStyle(
                  letterSpacing: 0.5,
                  color: Colors.green,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => (AdditionalMaterialPage()),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text(
                'Help and FAQ',
                style: TextStyle(
                  letterSpacing: 0.5,
                  color: Colors.green,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => (HelpAndFaq()),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.textsms),
              title: Text(
                'Feedback',
                style: TextStyle(
                  letterSpacing: 0.5,
                  color: Colors.green,
                ),
              ),
              trailing: StreamBuilder(
                  stream: db
                      .collection("mentorFeedbackLMS")
                      .where("read", "==", false)
                      .where("userId", "==", uid)
                      .onSnapshot,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data.docs.length);
                      return RawMaterialButton(
                        onPressed: () {},
                        child: Text(
                          "${snapshot.data.docs.length}",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        shape: new CircleBorder(),
                        elevation: 0.1,
                        fillColor: Colors.green,
                        constraints: BoxConstraints(
                          maxHeight: 75,
                          maxWidth: 75,
                          minHeight: 25,
                          minWidth: 25,
                        ),
                        // padding: const EdgeInsets.all(0.0),
                      );
                    }
                    return RawMaterialButton(
                      onPressed: () {},
                      child: Text(
                        "0",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      shape: new CircleBorder(),
                      elevation: 0.1,
                      fillColor: Colors.green,
                      constraints: BoxConstraints(
                        maxHeight: 75,
                        maxWidth: 75,
                        minHeight: 25,
                        minWidth: 25,
                      ),
                      // padding: const EdgeInsets.all(0.0),
                    );
                  }),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => (MentorFeedback(
                      uid: uid,
                    )),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.store),
              title: Text(
                'App Feedback',
                style: TextStyle(
                  color: Colors.green,
                  letterSpacing: 0.5,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();

                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Feedback',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                          letterSpacing: 0.5,
                        ),
                      ),
                      content: buildRatingView(context),
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.lock_open),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.green,
                  letterSpacing: 0.5,
                ),
              ),
              onTap: () {
                // _auth.signOut();
                _sharedpreference(context);
              },
            ),
            Divider(),
            Align(
              alignment: Alignment.bottomLeft * 0.4,
              child: Text(
                "The Startupreneur® All Rights Reserved",
                style:
                    TextStyle(), //fontStyle: FontStyle.italic  fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: <Widget>[
                //                  SizedBox(
                //                    width: MediaQuery.of(context).size.width * 0.05,
                //                  ),
                IconButton(
                  onPressed: () {
                    launcher(
                        "https://www.facebook.com/thestartupreneurofficial/");
                  },
                  icon: Icon(
                    FontAwesomeIcons.facebook,
                    color: Colors.green,
                    size: 18,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                IconButton(
                  onPressed: () {
                    launcher("https://www.linkedin.com/company/startupreneur/");
                  },
                  icon: Icon(
                    FontAwesomeIcons.linkedinIn,
                    color: Colors.green,
                    size: 18,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                IconButton(
                  onPressed: () {
                    launcher("https://twitter.com/TStartupreneur");
                  },
                  icon: Icon(
                    FontAwesomeIcons.twitter,
                    color: Colors.green,
                    size: 18,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                IconButton(
                  onPressed: () {
                    launcher("http://bit.ly/2Kp153P");
                  },
                  icon: Icon(
                    FontAwesomeIcons.medium,
                    color: Colors.green,
                    size: 18,
                  ),
                ),
              ],
            ),
            //              SizedBox(
            ////                height: MediaQuery.of(context).size.height * 0.01,
            ////              ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          // PageView(children: p
          Container(
            color: Colors.white,
            child: ChangeNotifierProvider<ModuleTraverse>(
              create: (_) => moduleTraverse,
              // ModuleTraverse(modnum: activity.modnum, order: 0),
              child: Consumer<ModuleTraverse>(
                builder: (context, traverse, _) {
                  print(
                      "activity.modnum is ********************************************************************************************************** ${traverse.modnum}");
                  return traverse.order < 1
                      ? PageView(
                          children: pages,
                        )
                      : traverse.nextPage();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListView buildRatingView(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        AutoSizeText(
          "We would love to hear the feedback on what you think about the program, be it content, design and everything else! You can let us know your ratings and comments below.",
          maxFontSize: 18,
          minFontSize: 14,
          textAlign: TextAlign.center,
          style: TextStyle(
            letterSpacing: 1,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Rate the Content",
              style: TextStyle(
                fontSize: 18,
                // fontStyle: FontStyle.italic,
                color: Colors.green,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RatingBar(
              allowHalfRating: true,
              onRatingUpdate: (ratingValue) {
                contentRating = ratingValue;
              },
              itemBuilder: (context, _) {
                return Icon(
                  Icons.star,
                  color: Colors.amber,
                );
              },
              itemSize: 35.0,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Rate the Structure",
              style: TextStyle(
                fontSize: 18,
                // fontStyle: FontStyle.italic,
                color: Colors.green,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RatingBar(
              allowHalfRating: true,
              onRatingUpdate: (ratingValue) {
                structureRating = ratingValue;
              },
              itemBuilder: (context, _) {
                return Icon(
                  Icons.star,
                  // color: Colors.green,
                  color: Colors.amber,
                );
              },
              itemSize: 35.0,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Overall Experience",
              style: TextStyle(
                fontSize: 18,
                // fontStyle: FontStyle.italic,
                color: Colors.green,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RatingBar(
              allowHalfRating: true,
              onRatingUpdate: (ratingValue) {
                experinceRating = ratingValue;
              },
              itemBuilder: (context, _) {
                return Icon(
                  Icons.star,
                  // color: Colors.green,
                  color: Colors.amber,
                );
              },
              itemSize: 35.0,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Any Comments",
              style: TextStyle(
                fontSize: 18,
                // fontStyle: FontStyle.italic,
                color: Colors.green,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.text,
              maxLines: 5,
              onChanged: (text) {
                commentText = text;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Comment your Feedback",
                hintStyle: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlineButton(
                // color: Colors.amberAccent,
                onPressed: () {
                  if (contentRating == 0 ||
                      experinceRating == 0 ||
                      structureRating == 0) {
                    Toast.show("Please submit your ratings as well.", context,
                        duration: Toast.LENGTH_LONG);
                  } else {
                    _sendFeedback().then((_) {
                      Toast.show(
                          "Thank you for your Feedback! We appreciate it.",
                          context,
                          duration: Toast.LENGTH_LONG);
                      commentText = null;
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text(
                  "Submit Feedback",
                ),
                borderSide: BorderSide(
                  color: Colors.green,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
        itemBuilder: centerTimelineBuilder,
        itemCount: doodles.length,
        lineColor: Colors.green,
        physics: BouncingScrollPhysics(),
        position: position,
      );

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final doodle = doodles[i];

    var val = 1;
    return TimelineModel(
        new GestureDetector(
          onTap: () async {
            print("value of i is $i");
            if (check(doodle.modNum)) {
              print(" true ${doodle.modNum}");
              // val = completedCourse[k];
              print("val is $val");
              // int progressNum = await SaveProgress.getProgerss(doodle.modNum);
              // print("PROGRESS NUM $progressNum");
              // if (progressNum == 0) {
                if (doodle.modNum == 12 || doodle.modNum == 14) {
                  traverse.updateModNum(activity.modnum);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ActivityController(
                        modName: doodle.modName,
                        modNum: doodle.modNum,
                        intro: [""],
                        index: 0,
                        headings: [""],
                        files: "",
                        order: 0,
                        buttons: [""],
                        textBox: [''],
                        suggestion: [''],
                        tableView: [''],
                      ), //FolderBuilder(completedCourse: completedCourse)),
                    ),
                  );
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         ModuleOverviewLoading(modNum: doodle.modNum),
                  //   ),
                  // );
                } else if (doodle.modNum != 12 && doodle.modNum != 15) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ActivityController(
                        modName: doodle.modName,
                        modNum: doodle.modNum,
                        intro: [""],
                        index: 0,
                        headings: [""],
                        files: "",
                        order: 0,
                        buttons: [""],
                        textBox: [''],
                        suggestion: [''],
                        tableView: [''],
                      ), //FolderBuilder(completedCourse: completedCourse)),
                    ),
                  );
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => QuoteLoading(modNum: doodle.modNum),
                  //   ),
                  // );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => (HustleStoreLoader()),
                    ),
                  );
                }
              // }
              //  else {
                // showDialog<bool>(
                //     context: context,
                //     builder: (_) {
                //       return AlertDialog(
                //         content: Text("Do you want to resume this Module?"),
                //         title: Text(
                //           "Continue",
                //         ),
                //         actions: <Widget>[
                //           FlatButton(
                //             child: Text(
                //               "Yes",
                //               style: TextStyle(color: Colors.green),
                //             ),
                //             onPressed: () {
                //               Navigator.of(context).pop(true);
                //               // Navigator.of(context).popUntil(ModalRoute.withName("/QuoteLoading"));
                //   traverse.updateModNum(activity.modnum);

                //              Navigator.of(context).push(
                //     MaterialPageRoute(
                //       builder: (context) => ActivityController(
                //         modName: doodle.modName,
                //         modNum: doodle.modNum,
                //         intro: [""],
                //         index: 0,
                //         headings: [""],
                //         files: "",
                //         order: 0,
                //         buttons: [""],
                //         textBox: [''],
                //         suggestion: [''],
                //         tableView: [''],
                //       ), //FolderBuilder(completedCourse: completedCourse)),
                //     ),
                //   );
                //             },
                //           ),
                //           FlatButton(
                //             child: Text(
                //               "No",
                //               style: TextStyle(color: Colors.red),
                //             ),
                //             onPressed: () {
                //               Navigator.of(context).pop(true);
                //               if (doodle.modNum == 11 || doodle.modNum == 14) {
                //                 Navigator.of(context).push(
                //                   MaterialPageRoute(
                //                     builder: (context) => ModuleOverviewLoading(
                //                         modNum: doodle.modNum),
                //                   ),
                //                 );
                //               } else if (doodle.modNum != 12) {
                //                 Navigator.of(context).push(
                //                   MaterialPageRoute(
                //                     builder: (context) =>
                //                         QuoteLoading(modNum: doodle.modNum),
                //                   ),
                //                 );
                //               } else {
                //                 Navigator.of(context).push(
                //                   MaterialPageRoute(
                //                     builder: (context) => (HustleStoreLoader()),
                //                   ),
                //                 );
                //               }
                //             },
                //           ),
                //         ],
                //       );
                //     });
              // }
            } else {
              print(" false");
            }
          },
          child: Padding(
            padding: (i % 2 == 0)
                ? EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.3, top: 40.0)
                : EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.3),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Tooltip(
                  height: MediaQuery.of(context).size.height * 0.2,
                  message: "Hello world",
                  preferBelow: false,
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
                            RaisedButton(
                              color: Colors.green,
                              textColor: Colors.black,
                              onPressed: () async {
                                print("value of i is $i");
                                if (check(doodle.modNum)) {
                                  print(" true ${doodle.modNum}");
                                  // val = completedCourse[k];
                                  print("val is $val");
                                  int progressNum =
                                      await SaveProgress.getProgerss(
                                          doodle.modNum);
                                  print("PROGRESS NUM $progressNum");
                                  if (progressNum == 0) {
                                    if (doodle.modNum == 12 ||
                                        doodle.modNum == 14) {
                                      traverse.updateModNum(activity.modnum);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ActivityController(
                                            modName: doodle.modName,
                                            modNum: doodle.modNum,
                                            intro: [""],
                                            index: 0,
                                            headings: [""],
                                            files: "",
                                            order: 0,
                                            buttons: [""],
                                            textBox: [''],
                                            suggestion: [''],
                                            tableView: [''],
                                          ), //FolderBuilder(completedCourse: completedCourse)),
                                        ),
                                      );
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         ModuleOverviewLoading(modNum: doodle.modNum),
                                      //   ),
                                      // );
                                    } else if (doodle.modNum != 12 &&
                                        doodle.modNum != 15) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ActivityController(
                                            modName: doodle.modName,
                                            modNum: doodle.modNum,
                                            intro: [""],
                                            index: 0,
                                            headings: [""],
                                            files: "",
                                            order: 0,
                                            buttons: [""],
                                            textBox: [''],
                                            suggestion: [''],
                                            tableView: [''],
                                          ), //FolderBuilder(completedCourse: completedCourse)),
                                        ),
                                      );
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (context) => QuoteLoading(modNum: doodle.modNum),
                                      //   ),
                                      // );
                                    } else {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              (HustleStoreLoader()),
                                        ),
                                      );
                                    }
                                  } else {
                                    showDialog<bool>(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            content: Text(
                                                "Do you want to resume this Module?"),
                                            title: Text(
                                              "Continue",
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                  // Navigator.of(context).popUntil(ModalRoute.withName("/QuoteLoading"));
                                                  SaveProgress
                                                          .getEventsFromFirestore(
                                                              doodle.modNum)
                                                      .then((_) {
                                                    List<int> arguments = [
                                                      doodle.modNum,
                                                      progressNum
                                                    ];
                                                    orderManagement
                                                        .moveNextIndex(
                                                            context, arguments);
                                                  });
                                                },
                                              ),
                                              FlatButton(
                                                child: Text(
                                                  "No",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                  if (doodle.modNum == 11 ||
                                                      doodle.modNum == 14) {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ModuleOverviewLoading(
                                                                modNum: doodle
                                                                    .modNum),
                                                      ),
                                                    );
                                                  } else if (doodle.modNum !=
                                                      12) {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            QuoteLoading(
                                                                modNum: doodle
                                                                    .modNum),
                                                      ),
                                                    );
                                                  } else {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            (HustleStoreLoader()),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  }
                                } else {
                                  print(" false");
                                }
                              },
                              child: Text("Start"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //                )
                  ),
                ),
                Container(
                  // color: Colors.grey[50],
                  width: 240.0,
                  height: 100.0,
                  child: Opacity(
                    opacity: 1.0,
                    child: lockUnlock(i, completedCourse),
                  ),
                ),
              ],
            ),
          ),
        ),
        position:
            i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == doodles.length,
        iconBackground: doodle.iconBackground,
        icon: doodle.icon);
  }
}
