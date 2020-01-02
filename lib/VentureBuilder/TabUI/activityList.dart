import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:startupreneur/VentureBuilder/UserInterface/ListActivity.dart';

import 'activityIntro.dart';

class ActivityListPage extends StatelessWidget {
  ActivityListPage({this.modName, this.modNum});
  dynamic modName, modNum;

  List intro = [];
  List headings = [];
  @override
  Widget build(BuildContext context) {
    print(modNum);
    return StreamBuilder(
      stream: Firestore.instance
          .collection("activity")
          .where("module", isEqualTo: modNum)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                        ),
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
          child: Text("hi"),
        );
      },
    );
  }
}


