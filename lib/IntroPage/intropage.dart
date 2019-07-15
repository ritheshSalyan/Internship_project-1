import 'package:flutter/material.dart';
import 'page1.dart';
import 'package:firebase_auth/firebase_auth.dart';

class introPage extends StatefulWidget {
  @override
  _introPageState createState() => _introPageState();
  
}


class _introPageState extends State<introPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          children: <Widget>[
            PageStarter1State()
          ],
        ),
    );
  }

   FirebaseAuth _auth = FirebaseAuth.instance;
   
   @override
  void initState() {
    super.initState();
    getUser().then((user) {
      if (user != null) {
        // send the user to the home page
        // homePage();
        print("already loged in");
      }
    });
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }
}