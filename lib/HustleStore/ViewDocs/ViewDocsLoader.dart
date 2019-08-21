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
    return CircularProgressIndicator(
      value: null,
      valueColor:AlwaysStoppedAnimation(Colors.green),
      strokeWidth: 5,
    );
  }
}