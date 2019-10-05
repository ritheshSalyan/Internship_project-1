import 'package:flutter/material.dart';
import 'IntroPageMain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class introPage extends StatefulWidget {
  @override
  _introPageState createState() => _introPageState();
}

class _introPageState extends State<introPage> {
  // FirebaseAuth _auth;
  Firestore db;
  // static SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    
  }

  // static Future<bool> firstLogin() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   try {
  //     var value = sharedPreferences.getString("UserId");
  //     if (value==null) {
  //       print(" log");
  //       return false;
  //     }
  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     // return ;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // firstLogin().then((s) {
    //   print(s);
    //   if (s==true) {
    //     print("hello");
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(
    //         builder: (context) => TimelinePage(title: "Road Map",),
    //       ),
    //     );
    //   }
    // });
    return Scaffold(
      body: PageView(
        children: <Widget>[
          PageStarter1State(con:context),
        ],
      ),
    );
  }
}
