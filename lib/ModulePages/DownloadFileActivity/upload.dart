import 'dart:io';

import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:startupreneur/ModuleOrderController/Types.dart';
import 'package:startupreneur/ModulePages/UserDetail.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/progress_dialog/progress_dialog.dart';
import 'package:startupreneur/saveProgress.dart';
import 'package:toast/toast.dart';
import 'package:path/path.dart' as p;

class Upload extends StatefulWidget {
  final int modNum, index;
  List<String> content;
  Upload({Key key, this.modNum, this.index, this.content}) : super(key: key);
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String uid;

  StorageUploadTask task;

  var progressDialog;

  File file;

  @override
  Widget build(BuildContext context) {
    // var outlineButton =
    return CustomeOffline(
      onConnetivity: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          elevation: 0.0,
          //  title:
          actions: <Widget>[
            GestureDetector(
              child: Icon(Icons.home),
              onTap: () {
                showDialog<bool>(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        content: Text(
                            "Are you sure you want to return to Home Page? "),
                        title: Text(
                          "Warning!",
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              "Yes",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              // Navigator.of(context).popUntil(ModalRoute.withName("/QuoteLoading"));
                              SaveProgress.preferences(
                                  widget.modNum, widget.index);
                              Navigator.of(context).popUntil(
                                  ModalRoute.withName("TimelinePage"));
                            },
                          ),
                          FlatButton(
                            child: Text(
                              "No",
                              style: TextStyle(color: Colors.green),
                            ),
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Complete your Activity",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02,
              ),
              child: Text(
               "${widget.content[2].replaceAll(RegExp(r'\. '), ".\n")}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
              ),
              child: OutlineButton(
                onPressed: () {
                  // downloadFile(context);
                  getFilePath();
                },
                // color: Colors.white,
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.file_upload,
                      color: Colors.white,
                    ),
                    Text(
                      "Upload",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future upload(File file) async {
    Auth auth = fb.auth();
    var user = await auth.currentUser;
    this.uid = user.uid;
    // String uri = Uri.decodeFull(file.path);
    // final RegExp regex = RegExp('([^?/]*\.(pdf|jpg|txt|docx))');
    // String fileName = regex.stringMatch(uri);
    // print(fileName.split("/"));
    String name = user.displayName;
    String extension = p.basename(file.path).split(".")[1];
    final fb.StorageReference storageRef = fb.storage()
        .ref()
        .child("userUpload")
        .child("${uid}_${name}")
        .child("${widget.modNum}_upload_${widget.index}." + extension);

   var task = storageRef.put(file);
    //  if(task.isInProgress){
    //    print("On Progress task");

    //  await task.future.then((data){
    //     String downloadUrl  = data.ref.getDownloadURL();
    //     });

    var data = await task.future;
    String downloadUrl = await data.ref.getDownloadURL().toString();
    // String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    Toast.show("Your Activity Uploaded Successfully", context,
        gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
    print("On downloadUrl task" + downloadUrl);
    //  }
    // if (taskSnapshot.) {
    //   print("On downloadUrl task"+downloadUrl);
    // }
    // if (task.isCanceled) {
    //   print("On isCanceled task");
    // }
    print("Hai");
    progressDialog.hide();
    List<dynamic> arguments = [widget.modNum, widget.index + 1];
    orderManagement.moveNextIndex(context, arguments);
  }

  void getFilePath() async {
    //  String _filePath;
    try {
      // String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      print("Before File picked ");
      // File file1 = await FilePicker.getFilePath(type: FileType.ANY);
      var file1 = await FilePicker.getFile(type: FileType.ANY);

      progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
      progressDialog.setMessage("Uploading....");
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
      upload(file1);
    } catch (e) {
      Toast.show("Upload failed, please try again", context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      print("Error while picking the file: " + e.toString());
      progressDialog.hide();
    }
  }
}
