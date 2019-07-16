import 'package:flutter/material.dart';
import 'package:startupreneur/timeline/trial.dart';
import 'page1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class introPage extends StatefulWidget {
  @override
  _introPageState createState() => _introPageState();
}

class _introPageState extends State<introPage> {
  FirebaseAuth _auth;
  static SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
  }

  static Future<bool> firstLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      var value = sharedPreferences.getString("UserId");
      if (value.isNotEmpty) {
        print(" log");
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      // return ;
    }
  }

  @override
  Widget build(BuildContext context) {
    firstLogin().then((s) {
      print(s);
      if (s==true) {
        print("hello");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => TimelinePage(title: "Road Map",),
          ),
        );
      }
    });
    return Scaffold(
      body: PageView(
        children: <Widget>[
          PageStarter1State(),
        ],
      ),
    );
  }
}
