import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class ViewDocsLoader extends StatefulWidget {
  @override
  _ViewDocsLoaderState createState() => _ViewDocsLoaderState();
}

class _ViewDocsLoaderState extends State<ViewDocsLoader> {
  SharedPreferences sharedPreferences;
String userId;
File file;
Firestore db;
List<dynamic> files=[];

@override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
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
  }
}