import 'package:flutter/material.dart';
import 'CaseStudyProcess.dart';
import 'firebaseConnect.dart';

class Loading extends StatefulWidget {
  Loading({Key key, this.modNum}) : super(key: key);
  final int modNum;
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    FirebaseFetch.getEventsFromFirestore(widget.modNum).then((dialogue) {
      if (dialogue.length != 0) {
        print("Widget.modNum is "+widget.modNum.toString());
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => IntroScreen_Liquid(
              dialogue: dialogue,
              modNum: widget.modNum,
            ),
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
