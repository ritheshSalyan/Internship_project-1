import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:startupreneur/progress_dialog/progress_dialog.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:startupreneur/ModulePages/DownloadFileActivity/upload.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/timeline/data.dart';
import 'package:toast/toast.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../../saveProgress.dart';

class DownloadFileActivity extends StatefulWidget {
  DownloadFileActivity(
      {Key key, this.modNum, this.order, this.file, this.content})
      : super(key: key);
  final int modNum, order;
  final String file;
  final List<String> content;
  @override
  _DownloadFileActivityState createState() => _DownloadFileActivityState();
}

class _DownloadFileActivityState extends State<DownloadFileActivity> {
  var exception;
  var file;
  int downloadRate = 0;
  dynamic sink;
  Dio dio = Dio();
  String modName = "";

  Future<void> downloadFile(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Download, isDismissible: false);

    Directory('/storage/emulated/0/Startupreneur').exists().then((yes) {
      if (!yes) {
        print("inside failed loop $yes");
        Directory('/storage/emulated/0/Startupreneur').create();
      } else {
        print("im here");
        Directory('/storage/emulated/0/Startupreneur/$modName').create();
      }
    }).catchError((e) {
      Directory('/storage/emulated/0/Startupreneur/$modName').create();
      setState(() {
        exception = "error creating";
      });
    });
    // Directory('/storage/emulated/0/Startupreneur/$modName')
    //     .create()
    //     .catchError((e) {
    //   print(e);
    //   setState(() {
    //     exception = "error creating";
    //   });
    // });

    String uri = Uri.decodeFull(widget.file);
    final RegExp regex = RegExp('([^?/]*\.(pdf|jpg|txt|docx))');
    String fileName = regex.stringMatch(uri);
    file = File('/storage/emulated/0/Startupreneur/$modName/$fileName');
    // progressDialog.setMessage("Downloading ...");

    // progressDialog.show();

    // print("task $taskId");
    try {
      for (var i in doodles) {
        if (i.modNum == widget.modNum) {
          setState(() {
            modName = i.modName;
          });
        }
      }

       FlutterDownloader.enqueue(
        url: '${widget.file}',
        savedDir: '/storage/emulated/0/Startupreneur/$modName',
        fileName: '$fileName',
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      ).then(
        (str){
          Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Upload(
          index: widget.order,
          modNum: widget.modNum,
          content: widget.content,
        ),
      ),);
      },);
      FlutterDownloader.registerCallback((id, status, progress) {
       print(progress);
      });
      // print(taskId);
      // progressDialog.update(progress: downloadRate);
      // await dio.download(widget.file, file.path,
      //     onReceiveProgress: (res, total) {
      //   // downloadRate
      //   print("res : $res , total: $total");
      //   setState(() {
      //     (res != null && total != null)
      //         ? progressDialog.update(
      //             progress: ((res / total) * 100).roundToDouble(),
      //             message: "Downloading",
      //           )
      //         : progressDialog.update(progress: 0, message: "Waiting");
      //   });
      // });
      progressDialog.hide();
      // Toast.show(
      //     "Check the $fileName in your Internal Storage in the folder 'Startupreneur' ",
      //     context,
      //     gravity: Toast.LENGTH_LONG,
      //     duration: 5);
      
    } catch (e) {
      print(e);
      // Toast.show("$e", context, gravity: Toast.BOTTOM, duration: 5);
      progressDialog.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    // var outlineButton =
    return CustomeOffline(
          onConnetivity: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          elevation: 0.0,
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
                                  widget.modNum, widget.order);
                              Navigator.of(context)
                                  .popUntil(ModalRoute.withName("TimelinePage"));
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
          // title:
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Text(
            "Activity",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.15,),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02,
              ),
              child: Text(
                "${widget.content[1]}",
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
                  downloadFile(context);
                },
                // color: Colors.white,
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.file_download,
                      color: Colors.white,
                    ),
                    Text(
                      "Download",
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
}
