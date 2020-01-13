// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;

class User{
  static fs.Firestore db =fb.firestore();
  static Future<String> getUserName(String uid) async {
      var document = await db.doc("user/$uid").get();
      return document.data()["name"];
  }
}