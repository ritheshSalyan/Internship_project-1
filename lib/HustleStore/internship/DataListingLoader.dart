import 'package:cloud_firestore/cloud_firestore.dart';
import 'DataListing.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataListingLoader extends StatefulWidget {
  @override
  _DataListingLoaderState createState() => _DataListingLoaderState();
}

class _DataListingLoaderState extends State<DataListingLoader> {
 static SharedPreferences sharedPreferences;
 static String userId;
 static Firestore db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore().then((title) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ListingData(),
        ),
      );
    });
    return Scaffold(
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
                "Loading... Please Wait !",
                style: TextStyle(
                  color: Colors.black,
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



  }
}
