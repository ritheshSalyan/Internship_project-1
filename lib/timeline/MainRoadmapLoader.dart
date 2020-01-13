import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:shared_preferences/shared_preferences.dart';
import 'MainRoadmap.dart';
import '../PaymentGateway/PaymentGateway.dart';

class RoadmapLoader extends StatefulWidget {
  RoadmapLoader({Key key, this.status}) : super(key: key);
  final bool status;

  @override
  _RoadmapLoaderState createState() => _RoadmapLoaderState();
}

class _RoadmapLoaderState extends State<RoadmapLoader> {
  fs.Firestore db;
  SharedPreferences _sharedPreferences;
  String userId;
  dynamic decision;

  @override
  void initState() {
    super.initState();
    print("inside roadmap loader");
  }

  Future<dynamic> preferences() async {
    // _sharedPreferences = await SharedPreferences.getInstance();
    // db = fb.firestore();
    // userId = _sharedPreferences.getString("UserId");
    // print("userId is $userId");
    // await db.collection("user").doc(userId).get().then((document) {
    //   print(document.data());
    //   decision = document.data()["payment"];
    //   print(decision);
    //   _sharedPreferences.setString(
    //       "institution", document.data()["institutionOrCompany"]);
    //   _sharedPreferences.setString("name", document.data()["name"]);

    //   print("decision is $decision");
    // });
    return true;
  }

  @override
  Widget build(BuildContext context) {
   
    return FutureBuilder(
        future: preferences(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return TimelinePage(
                title: "RoadMap",
                status: widget.status,
              );
            }
          }
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
                      "Loading... Please Wait",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
