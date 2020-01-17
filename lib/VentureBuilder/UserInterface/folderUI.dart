import 'package:auto_size_text/auto_size_text.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:startupreneur/VentureBuilder/TabUI/activityList.dart';
import 'package:startupreneur/VentureBuilder/UserInterface/ListActivity.dart';
import 'package:startupreneur/VentureBuilder/UserInterface/lockFolderIcon.dart';
import 'package:startupreneur/timeline/MainRoadmap.dart';
import 'package:startupreneur/timeline/data.dart';
import 'package:toast/toast.dart';

class FolderBuilder extends StatefulWidget {
  FolderBuilder({this.completedCourse});
  List<int> completedCourse;
  @override
  _FolderBuilderState createState() => _FolderBuilderState();
}

class _FolderBuilderState extends State<FolderBuilder> {
  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width * 0.7;
    // var height = MediaQuery.of(context).size.height * 0.2;
    double ratio = 0.3;
    Size size = MediaQuery.of(context).size;

    return Row(children: <Widget>[
      Container(
        width: size.width * (1 - ratio),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Venture Builder",
              textAlign: TextAlign.center,
            ),
          ),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
            ),
            itemCount: doodles.length - 1,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print(doodles[index].modName);

                  // if (widget.completedCourse.contains(doodles[index].modNum)) {
                    Scaffold.of(context).removeCurrentSnackBar();
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
                  // } else {
                  //   Toast.show(
                  //     "Please unlock the module",
                  //     context,
                  //     duration: Toast.LENGTH_LONG,
                  //   );
                  // }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // (!widget.completedCourse.contains(doodles[index].modNum))
                    //     ? LockFolderIcon()
                    // :
                    Icon(
                      Icons.folder,
                      size: 70,
                      color: Colors.black38,
                    ),
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
        ),
      ),
      Container(
        width: size.width * ratio,
        color: Colors.red,
        child: TimelinePage(),
      ),
    ]);
  }
}
