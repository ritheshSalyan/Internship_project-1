import 'dart:async';
import 'dart:io';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:startupreneur/NoInternetPage/NoNetPage.dart';
import '../../progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import '../../Auth/signin.dart';
import 'package:connectivity/connectivity.dart';
import 'package:permission/permission.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';

class TemplateDownload extends StatefulWidget {
  TemplateDownload({Key key, this.files, this.lengthList}) : super(key: key);

  List<dynamic> files;
  int lengthList;

  @override
  _TemplateDownloadState createState() => _TemplateDownloadState();
}

class _TemplateDownloadState extends State<TemplateDownload> {
  SharedPreferences sharedPreferences;
  String userId;
  Firestore db;
  String downloadUrl;
  String fileName;
  BuildContext context;
  File file;
  String exception;
  String folder = "downloads";
  // List<dynamic> files = [];
  StorageReference storageReference;
  ProgressDialog progressDialog;
  FirebaseMessaging _messaging = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context = this.context;

    _messaging.getToken().then((token) {
      print(token);
    });
    preferences();
    request();

    Analytics.analyticsBehaviour("Templates_Page_Hustle", "Template_Page");
  }

  void request() async {
    List<PermissionName> list = [PermissionName.Storage];
    var permission = await Permission.requestPermissions(list);
    var status = await Permission.getPermissionsStatus(list);
  }

  void preferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString("UserId");
    print(userId);
    String platfrom;
  }

  String fileNameRetriver(int index) {
    String uri = Uri.decodeFull(widget.files[index]);
    final RegExp regex = RegExp('([^?/]*\.(pdf))');
    String file = regex.stringMatch(uri);
    return file;
  }

  void downloadFile(int index, BuildContext context) async {
    progressDialog = ProgressDialog(context, ProgressDialogType.Normal);

    Directory('/storage/emulated/0/Startupreneur').exists().then((yes) {
      if (!yes) {
        print("inside failed loop $yes");
        Directory('/storage/emulated/0/Startupreneur').create();
      } else {
        print("im here");
        Directory('/storage/emulated/0/Startupreneur/templates').create();
      }
    }).catchError((e) {
      Directory('/storage/emulated/0/Startupreneur/templates').create();
      setState(() {
        exception = "error creating";
      });
    });
    Directory('/storage/emulated/0/Startupreneur/templates')
        .create()
        .catchError((e) {
      print(e);
      setState(() {
        exception = "error creating";
      });
    });
    String uri = Uri.decodeFull(widget.files[index]);
    final RegExp regex = RegExp('([^?/]*\.(pdf))');
    String fileName = regex.stringMatch(uri);
    file = File('/storage/emulated/0/Startupreneur/templates/$fileName');
    print("from download $fileName");
    print("${file.path}");

    progressDialog.setMessage("Downloading ...");
    progressDialog.show();
    // final taskId = await FlutterDownloader.enqueue(
    //   url: widget.files[index],
    //   savedDir: file.path,
    //   showNotification:
    //       true, // show download progress in status bar (for Android)
    //   openFileFromNotification:
    //       true, // click on notification to open downloaded file (for Android)
    // );

  // print("task $taskId");
    HttpClient client = new HttpClient();
    await client
        .getUrl(Uri.parse(widget.files[index]))
        .then((HttpClientRequest request) {
      print("nop");
      return request.close();
    }).then((HttpClientResponse response) {
      print("writing");
      try{
        response.pipe((file).openWrite()).catchError((e){
         Toast.show("Error while downloading! Please try again", context, gravity: Toast.BOTTOM, duration: 5);
        });
      print("done");
       progressDialog.hide();
      Toast.show("Check the $fileName in your Internal Storage in the folder 'Startupreneur' ", context, gravity: Toast.BOTTOM, duration: 5);
      }catch(e){
         Toast.show("Error while downloading!  Please try again ", context, gravity: Toast.BOTTOM, duration: 5);
      }
    }).catchError((e) {
      print("error $e");
      progressDialog.hide();
      Toast.show("Error downloading ...$e", context,
          gravity: Toast.BOTTOM,
          duration: 5,
          backgroundColor: Colors.red,
          textColor: Colors.black);
    });

    // storageReference = FirebaseStorage.instance.ref().child(userId).child(fileName);
    // final StorageFileDownloadTask storageFileDownloadTask = storageReference.writeToFile(file);
    // final int byteNumber = (await storageFileDownloadTask.future).totalByteCount;
    // print(byteNumber);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.9;
    final double height = MediaQuery.of(context).size.height * 0.75;

    Widget child;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Template Download",
        ),
      ),
      body: OfflineBuilder(
        connectivityBuilder:
            (context, ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            child = GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: width / height,
              ),
              itemCount: widget.lengthList,
              itemBuilder: (context, int index) {
                fileName = fileNameRetriver(index);
                return Card(
                  elevation: 5.0,
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: <Widget>[
                      Card(
                        child: Image.asset(
                          "assets/Images/pdf.png",
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.3),
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text("$fileName"),
                            ),
                            // SizedBox(width: 40),
                            IconButton(
                              alignment: Alignment.bottomRight,
                              onPressed: () {
                                downloadFile(index, context);
                              },
                              icon: Icon(Icons.file_download),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return (child);
        },
        child: NoNetPage(),
      ),
    );
  }
}
