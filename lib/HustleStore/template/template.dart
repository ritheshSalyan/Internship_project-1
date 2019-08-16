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
import '../../progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import '../../Auth/signin.dart';
import 'package:connectivity/connectivity.dart';

class TemplateDownload extends StatefulWidget {
  TemplateDownload({Key key, this.files, this.lengthList}) : super(key: key);

  List<dynamic> files;
  int lengthList;

  @override
  _TemplateDownloadState createState() => _TemplateDownloadState();
}

class _TemplateDownloadState extends State<TemplateDownload> {
  var connectivityStatus;
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> streamSubscription;
  SharedPreferences sharedPreferences;
  String userId;
  Firestore db;
  String downloadUrl;
  String fileName;
  BuildContext context;
  File file;
  String folder = "downloads";
  // List<dynamic> files = [];
  StorageReference storageReference;
  ProgressDialog progressDialog;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnection();
    context = this.context;
    preferences();
  }

  void checkConnection() {
    connectivity = new Connectivity();
    streamSubscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        print("$result");
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context)=>SigninPage(),
        //   )
        // );
      } else {
        print("$result");
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamSubscription.cancel();
  }

  void preferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString("UserId");
    print(userId);

    // db = Firestore.instance;
    // await db.collection("template").getDocuments().then((document) {
    //   document.documents.forEach((file) {
    //     files = file.data["files"];
    //   });
    // });
    // print(files.length);
  }

  String fileNameRetriver(int index) {
    String uri = Uri.decodeFull(widget.files[index]);
    final RegExp regex = RegExp('([^?/]*\.(pdf))');
    String file = regex.stringMatch(uri);
    return file;
  }

  void downloadFile(int index) async {
    progressDialog = ProgressDialog(context, ProgressDialogType.Normal);
    Directory('/storage/emulated/0/Startupreneur').exists().then((yes) {
      if (!yes) {
        print("inside failed loop $yes");
        Directory('/storage/emulated/0/Startupreneur').create();
      }
    }).catchError((e) {
      Directory('/storage/emulated/0/Startupreneur').create();
    });
    String uri = Uri.decodeFull(widget.files[index]);
    final RegExp regex = RegExp('([^?/]*\.(pdf))');
    String fileName = regex.stringMatch(uri);
    final dir = ('/storage/emulated/0/Startupreneur');
    final dir1 = ((await getExternalStorageDirectory()).path);

    print("File path $dir1");
    file = File('$dir/$fileName');
    print("from download $fileName");
    print("${file.path}");

    progressDialog.setMessage("Downloading ...");
    progressDialog.show();
    HttpClient client = new HttpClient();
    await client
        .getUrl(Uri.parse(widget.files[index]))
        .then((HttpClientRequest request) {
      print("nop");
      return request.close();
    }).then((HttpClientResponse response) {
      print("writing");
      response.pipe((file).openWrite());
      print("done");
      progressDialog.hide();
      Toast.show("check file in Startupreneur/$fileName in storage", context,
          gravity: Toast.BOTTOM, duration: 5);
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
        title: Text("Template Download"),
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
                                downloadFile(index);
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
          return(child);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'There are no bottons to push :)',
            ),
            new Text(
              'Just turn off your internet.',
            ),
          ],
        ),
      ),
    );
  }
}
