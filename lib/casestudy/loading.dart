import 'package:flutter/material.dart';
import 'package:startupreneur/casestudy/liquid_slide.dart';
import 'firebaseConnect.dart';
import 'intro.dart';
import 'liquid_slide.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    FirebaseFetch.getEventsFromFirestore(1).then((dialogue) {
      if (dialogue.length != 0) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>IntroScreen_Liquid(dialogue: dialogue),
          ),
        );
      }
    }).catchError((e) {
      return CircularProgressIndicator(
        backgroundColor: Colors.green,
      );
      //  return Container(
      // color: Colors.white,
    // );
    });
    return Container(
      color: Colors.white,
      // child: CircularProgressIndicator(
      //   backgroundColor: Colors.green,
      // ),
    );
     
  }
}
