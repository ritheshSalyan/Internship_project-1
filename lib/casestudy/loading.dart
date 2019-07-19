import 'package:flutter/material.dart';
import 'firebaseConnect.dart';
import 'intro.dart';
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
   FirebaseFetch.getEventsFromFirestore(1).then((dialogue){
     if(dialogue.length!=0){
         Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => IntroScreen(dialogue: dialogue),
          ),
        );

     }
   }
   );
   return Container();
  }
}