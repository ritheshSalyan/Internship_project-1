import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:startupreneur/progress_dialog/progress_dialog.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:startupreneur/ModulePages/DownloadFileActivity/upload.dart';
import 'package:toast/toast.dart';
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

  Future<void> downloadFile(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Download, isDismissible: false);

    Directory('/storage/emulated/0/Startupreneur').exists().then((yes) {
      if (!yes) {
        print("inside failed loop $yes");
        Directory('/storage/emulated/0/Startupreneur').create();
      } else {
        print("im here");
        Directory('/storage/emulated/0/Startupreneur/Module-${widget.modNum}')
            .create();
      }
    }).catchError((e) {
      Directory('/storage/emulated/0/Startupreneur/Module-${widget.modNum}')
          .create();
      setState(() {
        exception = "error creating";
      });
    });
    Directory('/storage/emulated/0/Startupreneur/Module-${widget.modNum}')
        .create()
        .catchError((e) {
      print(e);
      setState(() {
        exception = "error creating";
      });
    });

    String uri = Uri.decodeFull(widget.file);
    final RegExp regex = RegExp('([^?/]*\.(pdf))');
    String fileName = regex.stringMatch(uri);
    file = File(
        '/storage/emulated/0/Startupreneur/Module-${widget.modNum}/$fileName');
    // progressDialog.setMessage("Downloading ...");

    progressDialog.show();

    // print("task $taskId");
    try {
      // progressDialog.update(progress: downloadRate);
      await dio.download(widget.file, file.path,
          onReceiveProgress: (res, total) {
        // downloadRate
        print("res : $res , total: $total");
        setState(() {
          (res != null && total != null)
              ? progressDialog.update(
                  progress: ((res / total) * 100).roundToDouble(),
                  message: "Downloading",
                )
              : progressDialog.update(progress: 0, message: "Waiting");
        });
      });
      progressDialog.hide();
      Toast.show(
          "Check the $fileName in your Internal Storage in the folder 'Startupreneur' ",
          context,
          gravity: Toast.LENGTH_LONG,
          duration: 5);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Upload(
          index: widget.order,
          modNum: widget.modNum,
          content: widget.content,
        ),
      ));

      // var req = http.Client();
      // var response =
      //     await req.send(http.Request("GET", Uri.parse(widget.file)));
      // var len = response.contentLength;
      // print("length is $len");
      // await response.stream
      //     .map((s) {
      //       downloadRate += s.length;
      //       var res = (downloadRate / len).round();
      //       while (res != 100) {
      //         progressDialog.update(progress: res);
      //       }
      //       progressDialog.hide();
      //       print("done");
      //     })
      //     .pipe(sink)
      //     .catchError((e) {
      //       Toast.show("Error while downloading! Please try again", context,
      //           gravity: Toast.BOTTOM, duration: 5);
      //       progressDialog.hide();
      //     });
    } catch (e) {
      print(e);
      // Toast.show("$e", context, gravity: Toast.BOTTOM, duration: 5);
      progressDialog.hide();
    }

    // HttpClient client = new HttpClient();
    // await client
    //     .getUrl(Uri.parse(widget.file))
    //     .then((HttpClientRequest request) {
    //   print("nop");
    //   return request.close();
    // }).then((HttpClientResponse response) async {
    //   print("writing");
    //   try {
    //     var len = response.contentLength;
    //     print("length is $len");
    //     await response.asBroadcastStream().map((s) {
    //       downloadRate += s.length;
    //       print("downloadrate $downloadRate");
    //       var res = (downloadRate / len).round();
    //       progressDialog.update(progress: res);
    //     }).pipe(sink);

    //     // response.pipe((file).openWrite()).catchError((e) {
    //     //   Toast.show("Error while downloading! Please try again", context,
    //     //       gravity: Toast.BOTTOM, duration: 5);
    //     // });
    //     print("done");
    //     progressDialog.hide();
    //     Toast.show(
    //         "Check the $fileName in your Internal Storage in the folder 'Startupreneur' ",
    //         context,
    //         gravity: Toast.BOTTOM,
    //         duration: 5);
    //   } catch (e) {
    //     Toast.show("Error while downloading!  Please try again ", context,
    //         gravity: Toast.BOTTOM, duration: 5);
    //     progressDialog.hide();

    //   }
    // }).catchError((e) {
    //   print("error $e");
    //   progressDialog.hide();
    //   Toast.show("Error downloading ...$e", context,
    //       gravity: Toast.BOTTOM,
    //       duration: 5,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.black);
    // });

    // storageReference = FirebaseStorage.instance.ref().child(userId).child(fileName);
    // final StorageFileDownloadTask storageFileDownloadTask = storageReference.writeToFile(file);
    // final int byteNumber = (await storageFileDownloadTask.future).totalByteCount;
    // print(byteNumber);
  }

  @override
  Widget build(BuildContext context) {
    // var outlineButton =
    return Scaffold(
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
        title: Text(
          "Activity",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
            height: MediaQuery.of(context).size.height * 0.3,
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
    );
  }
}
