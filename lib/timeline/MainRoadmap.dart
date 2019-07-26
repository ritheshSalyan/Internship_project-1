import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../vocabulary/vocabulary.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'data.dart';
import '../Auth/signin.dart';
import 'package:video_player/video_player.dart';
import 'package:startupreneur/vocabulary/vocabulary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:startupreneur/Auth/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupreneur/ModulePages/ModuleOverview/ModuleOverview.dart';
import '../ModuleOrderController/Types.dart';

class TimelinePage extends StatefulWidget {
  TimelinePage({Key key, this.title, this.userEmail}) : super(key: key);
  final String title;
  final String userEmail;

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences sharedPreferences;
  bool _isPlaying = false;
  VideoPlayerController controller;
  BuildContext context;
  List<int> completedCourse = [1,2];
  FirebaseUser user;
  String value = "";
  var val= 1;
  
  String _url =
      "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350";

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
      padding: EdgeInsets.only(top: 20),
      child: Icon(
        Icons.lock,
        size: 30,
      ),
    );
  }

  void initState() {
    super.initState();
    // controller = VideoPlayerController.network(
    //     "https://firebasestorage.googleapis.com/v0/b/startupreneur-ace66.appspot.com/o/videos%2FAre%20You%20Ready%20720p.mp4?alt=media&token=583c2a4a-cae1-4e67-9898-cc5099474147")
    //   ..addListener(() {
    //     final bool isPlaying = controller.value.isPlaying;
    //     if (isPlaying != _isPlaying) {
    //       setState(() {
    //         _isPlaying = isPlaying;
    //       });
    //     }
    //   })
    //   ..initialize().then((_) {
    //     setState(() {});
    //   });
    // super.initState();
    preferences(context);
  }

  void preferences(BuildContext context) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      value = sharedPreferences.getString("UserEmail");
    });
    print("the value is $value");
    if (value == null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => SigninPage(),
      ));
    }
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.solidGem,
                    color: Colors.green,
                    size: 15,
                  ),
                ),
                Text(
                  "1000",
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
                accountName: Text("Subramanya c"),
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
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => VideoPlay(),
                  //   ),
                  // );
                },
              ),
              ListTile(
                leading: Icon(Icons.dashboard),
                title: Text(
                  'Dashboard',
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => (videoPlayerPage(title: "Video",modNum: 1,)),
                  //   ),
                  // );
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
                  'Hustle store',
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {
                  //   Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => (Loading()),
                  //   ),
                  // );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  'Settings',
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {},
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
                    builder: (context) => SignupPage(),
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
            // ClipPath(
            //   clipper: WaveClipperTwo(),
            //   child: Container(
            //     decoration: BoxDecoration(color: Colors.green),
            //     height: 200,
            //   ),
            // ),
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
                  builder: (context) => ModulePageIntro(modNum: i+1),
                  // builder: (context)=>Vocabulary(),
                ),
              );
              // break;
              // }
            }
            else{
              print("saaman false");
            }
          },
          child: Stack(
            children: <Widget>[
              Container(
                height: 150.0,
                width: 200.0,
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(0.0),
                  // ),
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
