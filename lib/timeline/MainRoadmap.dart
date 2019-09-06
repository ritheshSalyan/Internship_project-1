import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:startupreneur/ModulePages/FileActivity/FileUpload.dart';
import 'package:startupreneur/ModulePages/FileActivity/FileUploadLoader.dart';
import 'package:startupreneur/ModulePages/ModuleOverview/ModuleOverviewLoading.dart';
import 'package:startupreneur/ModulePages/Quote/quoteLoading.dart';
import 'package:startupreneur/NoInternetPage/NoNetPage.dart';
import 'package:startupreneur/saveProgress.dart';
import '../GeneralVocabulary/GeneralVocabulary.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'data.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:startupreneur/HustleStore/HustleStoreLoader.dart';
import '../Auth/signin.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ChatBoardRoom/ChatBoardRoomLoader.dart';
import '../ModuleOrderController/Types.dart';
import 'package:url_launcher/url_launcher.dart';
import '../ProfilePage/ProfilePageLoader.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:startupreneur/how_to_earn/how_to_earn.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
  bool position = true;
  var val = 1;
  bool timeSet = false;
  static String name = "User";
  PDFDocument doc;
  Flushbar<List<String>> flush;
  FirebaseMessaging _messaging = FirebaseMessaging();
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
    Directory('/storage/emulated/0/Startupreneur').exists().then((yes) {
      if (!yes) {
        print("inside failed loop $yes");
        Directory('/storage/emulated/0/Startupreneur').create();
      } else {
        print("im here");
        Directory('/storage/emulated/0/Startupreneur/templates').create();
      }
    }).catchError((e) {
      Directory('/storage/emulated/0/Startupreneur/templates').create();
    });
    // widget.status = true;
    _messaging.getToken().then((token) {
      print(token);
    });
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

  @override
  Widget build(BuildContext context) {
    Widget child;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.status) {
        Flushbar(
          titleText: Text(
            "Welcome to Startupreneur",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          backgroundColor: Colors.green,
          messageText: Column(
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Congratulations! You have received",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: " 1000 ",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(
                    text: "points as a registration bonus :) \n Keep Learning!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ]),
              ),
              OutlineButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Yay!",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          // duration: Duration(seconds: 5),
        )..show(context);
        setState(() {
          widget.status = false;
        });
      }
    });
    List<Widget> pages = [
      timelineModel(TimelinePosition.Center),
    ];
    orderManagement.currentIndex = 0;

    return OfflineBuilder(
      connectivityBuilder:
          (context, ConnectivityResult connectivity, Widget child) {
        final connected = connectivity != ConnectivityResult.none;
        if (connected) {
          child = Scaffold(
            extendBody: true,
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              title: Image.asset(
                "assets/Images/Capture.PNG",
                width: MediaQuery.of(context).size.width * 0.57,
              ),
              automaticallyImplyLeading: true,
              backgroundColor: Theme.of(context).primaryColorDark,
              elevation: 10.0,
              actions: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/Images/coins.png",
                      height: 15,
                      width: 15,
                    ),
                    Text(
                      " $gems",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
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
                  ListTile(
                    leading: Icon(
                      Icons.book,
                    ),
                    title: Text(
                      'Startup Dictionary',
                      style: TextStyle(
                        letterSpacing: 0.5,
                        color: Colors.green,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
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
                      'The Startupreneur GoldMine',
                      style: TextStyle(
                        color: Colors.green,
                        letterSpacing: 0.5,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
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
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => (ChatBoardRoomLoader()),
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
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         (FileUploadLoading(modNum: 2, index: 38)),
                      //   ),
                      // );
                      // Navigator.of(context).pop();
                      //  Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         (NoNetPage()),
                      //   ),
                      // );
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
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => (HowToEarn()),
                          fullscreenDialog: true,
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
                        width: MediaQuery.of(context).size.width * 0.05,
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
                PageView(children: pages),
              ],
            ),
          );
        }
        return child;
      },
      child: NoNetPage(),
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
    final textTheme = Theme.of(context).textTheme;

    int k;
    var val = 1;
    return TimelineModel(
        new GestureDetector(
          onTap: () async {
            print("value of i is $i");
            if (check(i)) {
              print(" true $i");
              // val = completedCourse[k];
              print("val is $val");
              int progressNum = await SaveProgress.getProgerss(i + 1);
              print("PROGRESS NUM ${progressNum}");
              if (progressNum == 0) {
                if (i == 11) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ModuleOverviewLoading(modNum: i + 1),
                    ),
                  );
                } else if (i != 12) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QuoteLoading(modNum: i + 1),
                    ),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => (HustleStoreLoader()),
                    ),
                  );
                }
              } else {
                showDialog<bool>(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        content: Text("Do you want to Continue ?"),
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
                              Navigator.of(context).pop(true);
                              // Navigator.of(context).popUntil(ModalRoute.withName("/QuoteLoading"));
                              SaveProgress.getEventsFromFirestore(i + 1)
                                  .then((_) {
                                List<int> arguments = [i + 1, progressNum];
                                orderManagement.moveNextIndex(
                                    context, arguments);
                              });
                            },
                          ),
                          FlatButton(
                            child: Text(
                              "No",
                              style: TextStyle(color: Colors.green),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                              if (i == 11) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ModuleOverviewLoading(modNum: i + 1),
                                  ),
                                );
                              } else if (i != 12) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        QuoteLoading(modNum: i + 1),
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
                          ),
                        ],
                      );
                    });
              }
            } else {
              print(" false");
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
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

  Future<dynamic> getFile() async {
    print("Before Picking File");
    var file = await FilePicker.getFilePath(type: FileType.ANY).then((file) {
      print("After inside Picking file");
      return file;
    }).catchError((e) {
      print("ERROR!!!!!!!!!!!" + e.toString());
    }).timeout(Duration(seconds: 10), onTimeout: () {
      print("Timeout*************************");
    });
  }
}
