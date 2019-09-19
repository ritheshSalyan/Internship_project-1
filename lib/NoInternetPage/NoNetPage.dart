import 'package:flutter/material.dart';
import 'package:smart_flare/smart_flare.dart';
import 'package:startupreneur/Analytics/Analytics.dart';

class NoNetPage extends StatefulWidget {
  @override
  _NoNetPageState createState() => new _NoNetPageState();
}

class _NoNetPageState extends State<NoNetPage> {

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Analytics.analyticsBehaviour("No_Internet_page_loading", "No_internet");
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SmartFlareActor(
            filename: "assets/animation/no internet con.flr",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            startingAnimation: "net",
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.0225,
            ),
            child:  Text(
            "No connection",
              textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 20,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
              // fontFamily: "Open Sans",
            ),
          ),
          ),
         
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.0225,
            ),
            child: Text(
              "Please check your internet connection\n and try again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
                // fontFamily: "Open Sans",
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
    ),
    );
  }
}
