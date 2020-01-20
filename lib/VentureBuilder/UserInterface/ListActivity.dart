import 'dart:convert';
import 'dart:io';
import 'dart:html' as html;
import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:file_picker/file_picker.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:startupreneur/ModulePages/UserDetail.dart' as u;
import 'package:startupreneur/VentureBuilder/TabUI/activityIntro.dart';
import 'package:toast/toast.dart';
import 'package:path/path.dart' as p;
// import 'package:flutter_file_picker/flutter_document_picker.dart';

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
    this.btnLength,
    this.buttons,
    this.suggestion,
    this.textBox,
    this.tableView,
  }) : super(key: key);
  int modNum, index, order, btnLength;
  String modName, files;
  List intro, headings, buttons,suggestion,textBox,tableView;
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
  List<int> _selectedFile;
  Uint8List _bytesData;

// Downloading the activity file
  Future<void> downloadFile(BuildContext context) async {
    String uri = Uri.decodeFull(widget.files);
    final RegExp regex =
        RegExp('([^?/]*\.(pdf|jpg|txt|docx|zip|jpeg|png|csv))');
    String fileName = regex.stringMatch(uri);
    downloadedFile = File('${widget.modName}/$fileName');

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
      });

      // progressDialog.hide();
    } catch (e) {
      print(e);
      // progressDialog.hide();
    }
  }

  //uploading activity file
  Future upload(html.File file, ProgressDialog progressDialog) async {
    Auth auth = fb.auth();
    var user = auth.currentUser;
    this.uid = user.uid;

    print("file is $file");

    String name = await u.User.getUserName(uid);
    print(file.name.split('.'));
    String extension = file.name.split('.')[1];
    final fb.StorageReference storageRef = fb
        .storage()
        .ref()
        .child("userUpload")
        .child("${uid}_${name}")
        .child("${widget.modNum}_upload_${widget.order}." + extension);

    var task = storageRef.put(file);
    var taskSnapshot = await task.future;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL().toString();
    Toast.show("Your Activity Uploaded Successfully", context,
        gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
    print("On downloadUrl task" + downloadUrl);
    progressDialog.hide();
  }

  void getFilePath() async {
    //  String _filePath;
    try {
      html.InputElement uploadInput = html.FileUploadInputElement();
      uploadInput.multiple = true;
      uploadInput.draggable = true;
      uploadInput.click();
      uploadInput.onChange.listen((e) {
        final files = uploadInput.files;
        final file = files[0];
        final reader = new html.FileReader();

        print("file is $file");

        upload(file, progressDialog);

        reader.onLoadEnd.listen((e) {
          _handleResult(reader.result);
        });
        reader.readAsDataUrl(file);
      });
    } catch (e) {
      Toast.show("Upload failed, please try again", context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      print("Error while picking the file: " + e.toString());
      progressDialog.hide();
    }
  }

  void _handleResult(Object result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
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
            body: Builder(
              builder: (context) => Stack(
                children: [
                  Swiper.children(
                    control: SwiperControl(color: Colors.white),
                    children: List<Widget>.generate(
                      widget.intro.length,
                      (int index) {
                        return ActivityIntro(
                          modName: widget.modName,
                          modNum: widget.modNum,
                          intro: widget.intro,
                          heading: widget.headings,
                          buttons: widget.buttons,
                          files: widget.files,
                          index: index,
                          btnLength: widget.btnLength,
                          textBox:widget.textBox,
                          suggestion:widget.suggestion,
                          tableView: widget.tableView,
                        );
                      },
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
