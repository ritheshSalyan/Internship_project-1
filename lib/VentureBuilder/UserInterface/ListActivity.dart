import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:startupreneur/VentureBuilder/TabUI/activityIntro.dart';

class ListActivities extends StatefulWidget {
  ListActivities(
      {Key key,
      this.modNum,
      this.modName,
      this.intro,
      this.headings,
      this.index})
      : super(key: key);
  int modNum, index;
  String modName;
  List intro, headings;
  @override
  _ListActivitiesState createState() => _ListActivitiesState();
}

class _ListActivitiesState extends State<ListActivities>
    with TickerProviderStateMixin {
  Future firestoreData;
  TabController tabController;
  File file;
   Future<void> downloadFile(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Download, isDismissible: false);
    Directory('/storage/emulated/0/Startupreneur').exists().then((yes) {
      if (!yes) {
        print("inside failed loop $yes");
        Directory('/storage/emulated/0/Startupreneur').create();
      } else {
        print("im here");
        Directory('/storage/emulated/0/Startupreneur/${widget.modName}').create();
      }
    }).catchError((e) {
      Directory('/storage/emulated/0/Startupreneur/${widget.modName}').create();
      setState(() {
        // exception = "error creating";
      });
    });
  

    String uri = Uri.decodeFull("");
    final RegExp regex =
        RegExp('([^?/]*\.(pdf|jpg|txt|docx|zip|jpeg|png|csv))');
    String fileName = regex.stringMatch(uri);
    file = File('/storage/emulated/0/Startupreneur/${widget.modName}/$fileName');
   
    try {
    
      FlutterDownloader.enqueue(
        url: '',
        savedDir: '/storage/emulated/0/Startupreneur/${widget.modName}',
        fileName: '$fileName',
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      ).then(
        (str) {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => Upload(
          //       index: widget.order,
          //       modNum: widget.modNum,
          //       content: widget.content,
          //     ),
          //   ),
          // );
        },
      );
      FlutterDownloader.registerCallback((id, status, progress) {
        print(progress);
      });
      
      progressDialog.hide();
      
    } catch (e) {
      print(e);
      progressDialog.hide();
    }
  }

  @override
  void initState() {
    super.initState();
    tabController = DefaultTabController.of(context);
    print(widget.intro.length);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.intro.length,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text(
                "${widget.modName}",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            body: Builder(
              builder: (context) => Stack(
                children: [
                  TabBarView(
                    children: List<Widget>.generate(
                      widget.intro.length,
                      (int index) {
                        return ActivityIntro(
                          intro: widget.intro,
                          heading: widget.headings,
                          index: index,
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        Scaffold.of(context).showBottomSheet(
                          (context) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.bottomCenter,
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Card(
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.file_download,
                                          color: Colors.green,
                                        ),
                                        title: RaisedButton(
                                          color: Colors.green,
                                          child: Text(
                                            "Activity Template Download",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.file_upload,
                                          color: Colors.green,
                                        ),
                                        title: RaisedButton(
                                          color: Colors.green,
                                          child: Text(
                                            "My Activity Upload",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: AnimatedContainer(
                        decoration: BoxDecoration(),
                        duration: Duration(seconds: 10),
                        curve: Curves.bounceIn,
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60.0),
                            // bottomRight: Radius.circular(50.0),
                          ),
                          child: Container(
                            height: 90,
                            color: Colors.green,
                            child: Center(
                              child: Text(
                                "Tap for options",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
