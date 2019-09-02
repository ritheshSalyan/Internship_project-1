// flutter build apk --target-platform android-arm,android-arm64 --split-per-abi

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:path_provider/path_provider.dart';
// import 'HustleStore/HustleStore.dart';

void main() async {
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  
  // var dir  = await getExternalStorageDirectory();
  // print("hey $dir");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // static const platform = MethodChannel("permission");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    request();
  }


  void request() async {
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }


  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'The Startupreneur',
      home: homePage(),
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
    );
  }
}
