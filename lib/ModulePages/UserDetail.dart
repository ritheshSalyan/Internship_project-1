// import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  static Future<String> getUserName(String uid) async {
      var document = await Firestore.instance.document("user/$uid").get();
      return document.data["name"];
  }
}