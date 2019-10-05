import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MainRoadmap.dart';
import '../PaymentGateway/PaymentGateway.dart';

class RoadmapLoader extends StatefulWidget {
RoadmapLoader({Key key,this.status}):super(key:key);
final bool status;

  @override
  _RoadmapLoaderState createState() => _RoadmapLoaderState();
}

class _RoadmapLoaderState extends State<RoadmapLoader> {


  Firestore db;
  SharedPreferences _sharedPreferences;
  String userId;
  dynamic decision;
  BuildContext context;

  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> preferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    db = Firestore.instance;
    userId = _sharedPreferences.getString("UserId");
    await db.collection("user").document(userId).get().then((document) {
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
        }
        else {  
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              settings: RouteSettings(name: "TimelinePage"),
              builder: (context) => TimelinePage(
                
                title: "RoadMap",
                status: widget.status,
              ),
            ),
          );
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (context) => SigninPage(
          //     ),
          //   ),
          // );
      }
    }
    );
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
}
