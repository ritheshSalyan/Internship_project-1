// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:startupreneur/VentureBuilder/TabUI/activityController.dart';
import 'package:startupreneur/VentureBuilder/UserInterface/ListActivity.dart';
import 'activityIntro.dart';

class ActivityListPage extends StatelessWidget {
  ActivityListPage({this.modName, this.modNum});
  dynamic modName, modNum;
  fs.Firestore db = fb.firestore();


  List intro = [];
  List headings = [];
  List  buttons = [];
  List suggestion = [];
  List textBox = [];
  List tableView = [];


  @override
  Widget build(BuildContext context) {
    print("Module number $modNum");

    db
        .collection("activity")
        .where("module", "==", modNum)
        .get()
        .then((snapshot) {
      // print("SNapshot data ");
      // print(snapshot.docs);
      int index = 0;
      
      print(snapshot.docs[index].data()['Page']);
      headings.clear();
      intro.clear();
      buttons.clear();


      snapshot.docs[index].data()['Page'].forEach((value) {
        headings.add(value);
      });
      snapshot.docs[index].data()['content'].forEach((value) {
        intro.add(value);
        print("object $value");
      });
      snapshot.docs[index].data()['buttons'].forEach((value) {
        buttons.add(value);
        print("object $value");
      });
      snapshot.docs[index].data()['suggestion'].forEach((value) {
        suggestion.add(value);
        print("object $value");
      });
      snapshot.docs[index].data()['textBox'].forEach((value) {
        textBox.add(value);
        print("object $value");
      });
       snapshot.docs[index].data()['tableView'].forEach((value) {
        tableView.add(value);
        print("object $value");
      });


      print("heading length ${headings.length}");
      print("intro length ${intro.length}");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ActivityController(
              modName: modName,
              modNum: modNum,
              intro: intro,
              headings: headings,
              buttons: buttons,
              index: index,
              textBox: textBox,
              suggestion: suggestion,
              tableView: tableView,
              files: snapshot.docs[index].data()['file'],
              order: snapshot.docs[index].data()['order']),
        ),
      );
    });
    // return StreamBuilder(
    //   stream: db
    //       .collection("activity")
    //       .where("module", "==", modNum).onSnapshot
    //       ,
    //   builder: (context, snapshot) {
    //     if(snapshot.hasError){
    //       print(snapshot.error);
    //     }

    //     print("Returning Conatiner");
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Text(
        "Loading  Activities available",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
    //   },
    // );
  }
}
