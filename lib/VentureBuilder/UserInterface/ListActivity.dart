import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:startupreneur/ModulePages/UserDetail.dart';
import 'package:startupreneur/VentureBuilder/TabUI/activityIntro.dart';
import 'package:toast/toast.dart';
import 'package:path/path.dart' as p;

class ListActivities extends StatefulWidget {
  ListActivities({
    Key key,
    this.modNum,
    this.modName,
    this.intro,
    this.headings,
    this.index,
    this.files,
    this.order,
  }) : super(key: key);
  int modNum, index, order;
  String modName, files;
  List intro, headings;
  @override
  _ListActivitiesState createState() => _ListActivitiesState();
}

class _ListActivitiesState extends State<ListActivities>
    with TickerProviderStateMixin {
  Future firestoreData;
  TabController tabController;
  File downloadedFile;
  String uid;
  StorageUploadTask task;
  var progressDialog;
  File file;

// Downloading the activity file
  Future<void> downloadFile(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Download, isDismissible: false);
    Directory('/storage/emulated/0/Startupreneur').exists().then((yes) {
      if (!yes) {
        print("inside failed loop $yes");
        Directory('/storage/emulated/0/Startupreneur').create();
      } else {
        print("im here");
        Directory('/storage/emulated/0/Startupreneur/${widget.modName}')
            .create();
      }
    }).catchError((e) {
      Directory('/storage/emulated/0/Startupreneur/${widget.modName}').create();
      setState(() {
        // exception = "error creating";
      });
    });

    String uri = Uri.decodeFull(widget.files);
    final RegExp regex =
        RegExp('([^?/]*\.(pdf|jpg|txt|docx|zip|jpeg|png|csv))');
    String fileName = regex.stringMatch(uri);
    downloadedFile =
        File('/storage/emulated/0/Startupreneur/${widget.modName}/$fileName');

    try {
      FlutterDownloader.enqueue(
        url: widget.files,
        savedDir: '/storage/emulated/0/Startupreneur/${widget.modName}',
        fileName: '$fileName',
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      ).then(
        (str) {},
      );
      FlutterDownloader.registerCallback((id, status, data) {
        print(data);
        if (data == 100) {
          Toast.show("Downloading  completed", context,
              duration: Toast.LENGTH_LONG);
        }
        // double d = data.roundToDouble();
        // progressDialog.update(maxProgress: 100, progress: d);
        // if (data == 100) {
        //   progressDialog.hide();
        // }
      });

      progressDialog.hide();
    } catch (e) {
      print(e);
      progressDialog.hide();
    }
  }

  //uploading activity file
  Future upload(File file, ProgressDialog progressDialog) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    this.uid = user.uid;
    // String uri = Uri.decodeFull(file.path);
    // final RegExp regex = RegExp('([^?/]*\.(pdf|jpg|txt|docx))');
    // String fileName = regex.stringMatch(uri);
    // print(fileName.split("/"));
    String name = await User.getUserName(uid);
    String extension = p.basename(file.path).split(".")[1];
    final StorageReference storageRef = FirebaseStorage.instance
        .ref()
        .child("userUpload")
        .child("${uid}_${name}")
        .child("${widget.modNum}_upload_${widget.order}." + extension);

    task = storageRef.putFile(file);
    StorageTaskSnapshot taskSnapshot = await task.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    Toast.show("Your Activity Uploaded Successfully", context,
        gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
    print("On downloadUrl task" + downloadUrl);
    progressDialog.hide();
  }

  void getFilePath() async {
    //  String _filePath;
    try {
      // String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      print("Before File picked ");
      // File file1 = await FilePicker.getFilePath(type: FileType.ANY);
      var file1 = await FilePicker.getFile(type: FileType.ANY);

      progressDialog =
          new ProgressDialog(context, type: ProgressDialogType.Normal);
      progressDialog.style(
        message: "Uploading...",
      );
      progressDialog.show();
      print("File picked successfully");

      if (file1 == null) {
        progressDialog.hide();
        return;
      }
      // print("File path: " + p.basename(file1.path));
      print("File path: ${file1.path}");

      setState(() {
        file = file1;
      });
      await upload(file1, progressDialog);
      progressDialog.hide();
    } catch (e) {
      Toast.show("Upload failed, please try again", context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      print("Error while picking the file: " + e.toString());
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
                  (widget.files.isNotEmpty)
                      ? Align(
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
                                          MediaQuery.of(context).size.height *
                                              0.20,
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
                                                      BorderRadius.circular(
                                                    20,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  print("inside");
                                                  downloadFile(context);
                                                },
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
                                                      BorderRadius.circular(
                                                    20,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  getFilePath();
                                                },
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
                        )
                      : Align(
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
                                          MediaQuery.of(context).size.height *
                                              0.20,
                                      child: Center(
                                        child: Card(
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
                                                      BorderRadius.circular(
                                                          20)),
                                              onPressed: () {
                                                getFilePath();
                                              },
                                            ),
                                          ),
                                        ),
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
