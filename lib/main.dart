// flutter build apk --target-platform android-arm,android-arm64 --split-per-abi

import 'dart:async';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:startupreneur/Auth/signin.dart';
import 'package:startupreneur/ChatBoardRoom/ChatBoardRoomLoader.dart';
import 'package:startupreneur/VentureBuilder/TabUI/activityController.dart';
import 'package:startupreneur/VentureBuilder/TabUI/activityList.dart';
import 'package:startupreneur/VentureBuilder/UserInterface/folderUI.dart';
import 'package:startupreneur/timeline/MainRoadmapLoader.dart';
import 'home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'HustleStore/HustleStore.dart';

void main()  {
  
    runApp(MyApp());
}
class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // static const platform = MethodChannel("permission");
  // FirebaseAnalytics analytics = FirebaseAnalytics();
  // FirebaseAnalyticsObserver observer;

  @override 
  void initState() {
    print("inside init");
    super.initState();
    // request();
  }

  void request() async {
    try {
          await PermissionHandler()
              .requestPermissions([PermissionGroup.storage]);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    return MaterialApp( 
      title: 'The Startupreneur',
      // navigatorObservers: [
      //   FirebaseAnalyticsObserver(analytics: analytics),
      // ],
      home: homePage(),//homePage(),//
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        brightness: Brightness.light,
        primaryColorDark: Colors.white,
        buttonColor: Color(0x009423),
        accentColor: Color(0x009423),
        scaffoldBackgroundColor: Colors.white,
        textSelectionColor: Colors.black,
      ),
      routes: <String, WidgetBuilder>{
        '/chat': (BuildContext context) => new ChatBoardRoomLoader(),
      },
    );
  }
}
