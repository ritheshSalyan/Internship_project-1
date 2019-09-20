// flutter build apk --target-platform android-arm,android-arm64 --split-per-abi

import 'dart:async';
import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:startupreneur/ChatBoardRoom/ChatBoardRoomLoader.dart';
import 'home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:path_provider/path_provider.dart';
// import 'HustleStore/HustleStore.dart';

void main() async {
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runZoned<Future<void>>(() async {
    runApp(MyApp());
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // static const platform = MethodChannel("permission");
  FirebaseAnalytics analytics = FirebaseAnalytics();
  FirebaseAnalyticsObserver observer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    request();
  }

  void request() async {
    try {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.storage]);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'The Startupreneur',
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      home: homePage(analytics: analytics, observer: observer),
      debugShowCheckedModeBanner: true,
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
