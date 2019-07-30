import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:startupreneur/ModulePages/Quote/quoteLoading.dart';
import '../GeneralVocabulary/GeneralVocabulary.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'data.dart';
import '../ModulePages/SummaryPage/SummaryPage.dart';
import '../ModulePages/DecisionGame/DecisionGame.dart';
import 'package:startupreneur/HustleStore/HustleStoreLoader.dart';
import '../ModulePages/FileActivity/FileUploadLoader.dart';
import 'package:startupreneur/HustleStore/HustleStore.dart';
import '../Auth/signin.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupreneur/ModulePages/ModuleOverview/ModuleOverview.dart';
import '../Trial/trial.dart';

import '../ModuleOrderController/Types.dart';
import 'package:startupreneur/trial.dart';

import '../ProfilePage/ProfilePageLoader.dart';

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
      padding: EdgeInsets.only(top: 100),
      child: Icon(
        Icons.lock,
        size: 20,
      ),
    );
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
// <<<<<<< HEAD
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
      }
      );});
// =======
//    db.collection("user").where("uid",isEqualTo: uid).getDocuments().then((document){
//     document.documents.forEach((value){
//       setState(() {
//         gems = value["points"]; 
// >>>>>>> 9fe17a210442af7b76d825121f04c163997c1107
//       });
//     });

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
    for (int k = 0; k < completedCourse.length; k++) {
      if (completedCourse[k] == i + 1) {
        val = completedCourse[k];
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      timelineModel(TimelinePosition.Center),
    ];
    orderManagement.currentIndex = 0;

    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          backgroundColor: Theme.of(context).primaryColorDark,
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
                  height: 20,
                  width: 20,
                ),
                Text(
                  " $gems",
                  style: TextStyle(color: Colors.black),
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
                accountEmail: Text(value),
                accountName: Text(name),
                currentAccountPicture: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(_url),
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.assignment_ind,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileLoading(uid:uid),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text(
                  'Vocabulary',
                  style: TextStyle(color: Colors.green),
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
                  style: TextStyle(color: Colors.green),
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
                leading: Icon(Icons.settings),
                title: Text(
                  'Settings',
                  style:
                      TextStyle(color: Colors.green, fontFamily: "Slabo_27px"),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(

                      builder: (context) => (SummaryPage()),

                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.lock_open),
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {
                  _auth.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SigninPage(),
                  ));
                },
              ),
              Divider(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "All right reserved at thestartupreneur.co",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                ),
              )
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
          onTap: () {
            print("value of i is $i");
            // for (k = 0; k < completedCourse.length; k++) {
            // if (completedCourse[k] == i + 1) {

            if (check(i)) {
              print("saaman true $i");
              // val = completedCourse[k];
              print("val is $val");
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => QuoteLoading(modNum: i + 1),
                  // builder: (context)=>Vocabulary(),
                ),
              );
              // break;
              // }
            } else {
              print("saaman false");
            }
          },
          child: Stack(
            children: <Widget>[
              Container(
                height: 200.0,
                width: 200.0,
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Image.network(doodle.doodle),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(doodle.time, style: textTheme.caption),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          doodle.name,
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
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
              ),
              Container(
                width: 200.0,
                height: 150.0,
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
