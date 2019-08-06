import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MainRoadmap.dart';
import '../PaymentGateway/PaymentGateway.dart';

class RoadmapLoader extends StatefulWidget {
  @override
  _RoadmapLoaderState createState() => _RoadmapLoaderState();
}

class _RoadmapLoaderState extends State<RoadmapLoader> {


  Firestore db;
  SharedPreferences _sharedPreferences;
  String UserId;
  dynamic decision;
  BuildContext context;


  @override
  void initState() {
    super.initState();
  }


  Future<dynamic> preferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    db = Firestore.instance;
    UserId = _sharedPreferences.getString("UserId");
    await db.collection("user").document(UserId).get().then((document) {
      decision = document.data["payment"];
      print("decision is $decision");
    });
    return decision;
  }


  @override
  Widget build(BuildContext context) {
    preferences().then(
      (val) {
        print("thrown decision is $val");
        if (!val) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => PaymentGatewayPage(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => TimelinePage(
                title: "RoadMap",
              ),
            ),
          );
        }
      },
    );
    return Scaffold(
      body: CircularProgressIndicator(),
    );
  }
}
