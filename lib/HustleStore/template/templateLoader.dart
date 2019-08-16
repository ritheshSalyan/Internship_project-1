import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startupreneur/HustleStore/template/template.dart';

class TemplateLoader extends StatefulWidget {
  @override
  _TemplateLoaderState createState() => _TemplateLoaderState();
}

class _TemplateLoaderState extends State<TemplateLoader> {
SharedPreferences sharedPreferences;
String userId;
File file;
Firestore db;
List<dynamic> files=[];


  void initState() {
    // TODO: implement initState
    super.initState();
   
  }

  Future<List<dynamic>> preferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString("UserId");
    print(userId);

    db = Firestore.instance;
    await db.collection("template").getDocuments().then((document) {
      document.documents.forEach((file) {
        files = file.data["files"];
      });
    });
    return files;
  }



  @override
  Widget build(BuildContext context) {

    preferences().then((fileList){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context)=>TemplateDownload(
              files: fileList,
              lengthList: fileList.length
            )
          )
        );
    });
    return Scaffold(
    );
  }
}