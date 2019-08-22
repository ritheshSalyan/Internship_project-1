import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'HustleStore.dart';

class HustleStoreLoader extends StatefulWidget {
  @override
  _HustleStoreLoaderState createState() => _HustleStoreLoaderState();
}

class _HustleStoreLoaderState extends State<HustleStoreLoader> {
  static dynamic gems;
  static String userId = "";
  static SharedPreferences sharedPreferences;
  static final Firestore db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore().then(
      (title) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HustleStore(
              points: gems,
            ),
          ),
        );
      },
    );


    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              strokeWidth: 5,
              value: null,
              valueColor: new AlwaysStoppedAnimation(Colors.green),
            ),
            SizedBox(
              height: 10,
            ),
            Material(
              color: Colors.transparent,
              child: Text(
                "Loading...",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> getEventsFromFirestore() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString("UserId");
    await db
        .collection("user")
        .where("uid", isEqualTo: userId)
        .getDocuments()
        .then((document) {
      document.documents.forEach((value) {
        print(value["points"]);
        gems = value["points"];
      });
    });
  }
}
