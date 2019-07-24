import 'package:flutter/material.dart';
import 'CaseStudyProcess.dart';
import 'firebaseConnect.dart';

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
        backgroundColor: Theme.of(context).primaryColor,
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
