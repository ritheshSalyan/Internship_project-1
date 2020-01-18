import 'package:flutter/material.dart';
import 'CaseStudyProcess.dart';
import 'firebaseConnect.dart';

class Loading extends StatefulWidget {
  Loading({Key key, this.modNum,this.index}) : super(key: key);
  final int modNum,index;
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    // FirebaseFetch.getEventsFromFirestore(widget.modNum).then((dialogue) {
    //   if (dialogue.length != 0) {
    //     // print("Widget.modNum is "+widget.modNum.toString());
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(
    //         builder: (context) => IntroScreen_Liquid(
    //           dialogue: dialogue,
    //           modNum: widget.modNum,
    //           index:widget.index+1,
    //         ),
    //       ),
    //     );
    //   }
    // }).catchError((e) {
    //   return CircularProgressIndicator(
    //     backgroundColor: Theme.of(context).primaryColor,
    //   );
    //   //  return Container(
    //   // color: Colors.white,
    //   // );
    // });
    return FutureBuilder(
      future: FirebaseFetch.getEventsFromFirestore(widget.modNum,widget.index),
      builder: (context, snapshot) {
       if(snapshot.hasData)
       {
          return IntroScreen_Liquid(
              dialogue: snapshot.data,
              modNum: widget.modNum,
              index:widget.index+1,
            );
       }
       else{ return Container(
          color: Colors.white,
          // child: CircularProgressIndicator(
          //   backgroundColor: Colors.green,
          // ),
        );}
      }
    );
  }
}
