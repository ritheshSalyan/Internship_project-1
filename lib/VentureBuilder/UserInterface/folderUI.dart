import 'package:auto_size_text/auto_size_text.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:startupreneur/VentureBuilder/TabUI/activityList.dart';
import 'package:startupreneur/VentureBuilder/UserInterface/ListActivity.dart';
import 'package:startupreneur/VentureBuilder/UserInterface/lockFolderIcon.dart';
import 'package:startupreneur/timeline/data.dart';

class FolderBuilder extends StatefulWidget {
  @override
  _FolderBuilderState createState() => _FolderBuilderState();
}

class _FolderBuilderState extends State<FolderBuilder> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.7;
    var height = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Venture Builder",
          textAlign: TextAlign.center,
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: width / height,
        ),
        itemCount: doodles.length - 1,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print(doodles[index].modName);
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => ListActivities(
              //       modNum: doodles[index].modNum,
              //       modName: doodles[index].modName,
              //     ),
              //   ),
              // );
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  content: ActivityListPage(
                    modName: doodles[index].modName,
                    modNum: doodles[index].modNum,
                  ),
                  behavior: SnackBarBehavior.fixed,
                  duration: Duration(hours: 5),
                  // animation: 
                  // elevation: 8.0,
                  backgroundColor: Colors.white,
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                LockFolderIcon(),
                AutoSizeText(
                  "${doodles[index].modName}",
                  maxLines: 1,
                  minFontSize: 14,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
