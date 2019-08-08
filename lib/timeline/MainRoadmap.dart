import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:startupreneur/ModulePages/Quote/quoteLoading.dart';
import '../GeneralVocabulary/GeneralVocabulary.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'data.dart';

import 'package:gradient_widgets/gradient_widgets.dart';
import '../ModulePages/SummaryPage/SummaryPageLoader.dart';
import '../ModulePages/DecisionGame/DecisionGame.dart';
import 'package:startupreneur/HustleStore/HustleStoreLoader.dart';
import '../ModulePages/FileActivity/FileUploadLoader.dart';
import 'package:startupreneur/HustleStore/HustleStore.dart';
import '../Auth/signin.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupreneur/ModulePages/ChatBoardRoom/ChatBoardRoom.dart';
import '../Trial/trial.dart';
import '../ModuleOrderController/Types.dart';
import 'package:url_launcher/url_launcher.dart';
import '../ProfilePage/ProfilePageLoader.dart';
import '../Trial/AnimationTrial.dart';

class TimelinePage extends StatefulWidget {
  TimelinePage({Key key, this.title, this.userEmail}) : super(key: key);
  final String title;
  final String userEmail;

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore db = Firestore.instance;
  SharedPreferences sharedPreferences;
  bool _isPlaying = false;
  int gems = 0;
  VideoPlayerController controller;
  BuildContext context;
  List<int> completedCourse = [];
  FirebaseUser user;
  String value = "";
  String uid = "";
  var val = 1;
  static String name = "User";

  String _url =
      "https://firebasestorage.googleapis.com/v0/b/thestartupreneur-e1201.appspot.com/o/images%2Favatar.png?alt=media&token=d6c06033-ba6d-40f9-992c-b97df1899102";

  Widget lockUnlock(int i, List<int> id) {
    final doodle = doodles[i];
    for (var k = 0; k < id.length; k++) {
      if (doodle.time == "Module ${id[k]}") {
        return Icon(
          Icons.lock_open,
          size: 0.0,
        );
      }
    }
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: Icon(
        Icons.lock,
        size: 20,
      ),
    );
  }

  void _Sharedpreference(BuildContext context) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => SigninPage(),
    ));
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
    preferences(context);
  }

  void preferences(BuildContext context) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      value = sharedPreferences.getString("UserEmail");
      uid = sharedPreferences.getString("UserId");
    });
    print("the value is $value");
    if (value == null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => SigninPage(),
      ));
    }

    await db
        .collection("user")
        .where("uid", isEqualTo: uid)
        .getDocuments()
        .then((document) {
      document.documents.forEach((value) {
        setState(() {
          gems = value["points"];
          name = value["name"];
          _url = value["profile"];
        });
      });
    });

// =======
//    db.collection("user").where("uid",isEqualTo: uid).getDocuments().then((document){
//     document.documents.forEach((value){
//       setState(() {
//         gems = value["points"];
// >>>>>>> 9fe17a210442af7b76d825121f04c163997c1107
    //    });
    //  });

    await db
        .collection("user")
        .where("uid", isEqualTo: uid)
        .getDocuments()
        .then((document) {
      document.documents.forEach((value) {
        for (int i in value["completed"]) {
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
    for (int k = 0; k < completedCourse.length; k++) {
      if (completedCourse[k] == i + 1) {
        val = completedCourse[k];
        return true;
      }
    }
    return false;
  }

//
//  @override
//  void dispose() {
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      timelineModel(TimelinePosition.Center),
    ];
    orderManagement.currentIndex = 0;

    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Image.asset(
            "assets/Images/Capture.PNG",
            width: MediaQuery
                .of(context)
                .size
                .width * 0.57,
          ),
          automaticallyImplyLeading: true,
          backgroundColor: Theme
              .of(context)
              .primaryColorDark,
          elevation: 10.0,
          actions: <Widget>[
            Row(
              children: <Widget>[
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(
                //     FontAwesomeIcons.solidGem,
                //     color: Colors.green,
                //     size: 15,
                //   ),
                // ),
                Image.asset(
                  "assets/Images/coins.png",
                  height: 15,
                  width: 15,
                ),
                Text(
                  " $gems",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                ),
              ],
            )
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
                    Image.asset(
                      "assets/Images/coins.png",
                      height: 20,
                      width: 20,
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
                currentAccountPicture: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(_url),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileLoading(uid: uid),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text(
                  'Startup Dictionary',
                  style: TextStyle(
                    letterSpacing: 0.5,
                    color: Colors.green,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => (Vocabulary()),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.store),
                title: Text(
                  'Hustle Store',
                  style: TextStyle(
                    color: Colors.green,
                    letterSpacing: 0.5,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => (HustleStoreLoader()),
                    ),
                  );
                },
              ),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                      (ChatBoardRoom()),
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
                      builder: (context) => ( MyHomePage(title: 'Flutter Demo Home Page')),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  'How to Earn Points',
                  style: TextStyle(
                    letterSpacing: 0.5,
                    color: Colors.green,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => (ChatHome()),
                    ),
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
                  _auth.signOut();
                  _Sharedpreference(context);
//                  Navigator.of(context).pushReplacement(MaterialPageRoute(
//                    builder: (context) => SigninPage(),
//                  ));
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.05,
                  ),
                  IconButton(
                    onPressed: () {
                      launcher(
                          "https://www.linkedin.com/company/startupreneur/");
                    },
                    icon: Icon(
                      FontAwesomeIcons.linkedinIn,
                      color: Colors.green,
                      size: 18,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.05,
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.05,
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
            PageView(
              children: pages,
            ),
          ],
        ));
  }

  timelineModel(TimelinePosition position) =>
      Timeline.builder(
        itemBuilder: centerTimelineBuilder,
        itemCount: doodles.length,
        lineColor: Colors.green,
        physics: BouncingScrollPhysics(),
        position: position,
      );

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final doodle = doodles[i];
    final textTheme = Theme
        .of(context)
        .textTheme;

    int k;
    var val = 1;
    return TimelineModel(
        new GestureDetector(
          onTap: () {
            print("value of i is $i");
            // for (k = 0; k < completedCourse.length; k++) {
            // if (completedCourse[k] == i + 1) {

            if (check(i)) {
              print(" true $i");
              // val = completedCourse[k];
              print("val is $val");
              if (i != 12) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => QuoteLoading(modNum: i + 1),
                  ),
                );
                // builder: (context)=>Vocabulary(),
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => (HustleStoreLoader()),
                  ),
                );
              }

              // break;
              // }
            } else {
              print(" false");
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                color: Colors.grey[50],

                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.37,
//              height: 210.0,
//                width: 145.0,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.43,
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
//                    margin: EdgeInsets.symmetric(vertical: 16.0),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Image.network(doodle.doodle),
                        Image.asset(
                          doodle.doodle,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.09,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        // Text(doodle.time, style: textTheme.caption),
                        // const SizedBox(
                        //   height: 8.0,
                        // ),
                        doodle.name,
//                        Text(
//                          doodle.name,
////                           style: TextStyle(fontSize: 16,),
//                          // fontWeight: FontWeight.w400
//                          // ),
//                          style: TextStyle(
////                            color: Colors.white,
//                              fontSize: 16,
//                              letterSpacing: 0.5,
//                              // fontFamily: "Open Sans",
//                              fontWeight: FontWeight.w400),
//                          textAlign: TextAlign.center,
//                        ),
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
        position:
        i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == doodles.length,
        iconBackground: doodle.iconBackground,
        icon: doodle.icon);
  }
}
