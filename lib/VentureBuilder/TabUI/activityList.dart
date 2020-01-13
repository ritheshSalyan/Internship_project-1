// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:startupreneur/VentureBuilder/UserInterface/ListActivity.dart';

import 'activityIntro.dart';

class ActivityListPage extends StatelessWidget {
  ActivityListPage({this.modName, this.modNum});
  dynamic modName, modNum;
  fs.Firestore db = fb.firestore();
  List intro = [];
  List headings = [];
  @override
  Widget build(BuildContext context) {
    print(modNum);
    return StreamBuilder(
      stream: db
          .collection("activity")
          .where("module", "==", modNum)
          .onSnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.documents.length != 0) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return GradientCard(
                gradient: LinearGradient(
                  colors: [
                    Colors.green,
                    Color(0xFF30B8AA),
                  ],
                ),
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  onTap: () {
                    print(snapshot.data.documents[index].data['Page']);
                    headings.clear();
                    intro.clear();
                    snapshot.data.documents[index].data['Page']
                        .forEach((value) {
                      headings.add(value);
                    });
                    snapshot.data.documents[index].data['content']
                        .forEach((value) {
                      intro.add(value);
                    });
                    print("heading length ${headings.length}");
                    print("intro length ${intro.length}");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ListActivities(
                            modName: modName,
                            modNum: modNum,
                            intro: intro,
                            headings: headings,
                            index: index,
                            files: snapshot.data.documents[index].data['file'],
                            order:
                                snapshot.data.documents[index].data['order']),
                      ),
                    );
                  },
                  child: ListTile(
                    subtitle: Text("Tap to open"),
                    title: Text("Activity ${index + 1}"),
                    leading: Icon(
                      Icons.access_time,
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height*0.3,
          child: Text(
            "No Activities available",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        );
      },
    );
  }
}
