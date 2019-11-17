import 'package:flutter/material.dart';
// import 'package:intro_slider/dot_animation_enum.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:startupreneur/ModulePages/UserDetail.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'Page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:startupreneur/progress_dialog/progress_dialog.dart';
import '../../ModuleOrderController/Types.dart';
//import 'package:intro_slider_example/home.dart';
import 'package:toast/toast.dart';
import '../../saveProgress.dart';

class FileUpload extends StatefulWidget {
  FileUpload({Key key, this.modNum, this.index, this.pages}) : super(key: key);
  int modNum, index;
  List<Page> pages;
  @override
  FileUploadState createState() => new FileUploadState();
}

//------------------ Default config ------------------
class FileUploadState extends State<FileUpload> {
  List<Container> slides = new List();


   @override
  void initState() {

    super.initState();
    Analytics.analyticsBehaviour("File_Uploading_Page_Module", "File_Upload_Page");
  }

  File file;
  String uid;
  static ProgressDialog progressDialog;
  StorageUploadTask task;
  Widget renderDoneBtn() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: OutlineButton(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          focusColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.white, width: 3)),
          onPressed: () {
            getFilePath();
          },
          child: Row(
            children: <Widget>[
              Text(
                "Upload",
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(left: 1),
                child: Icon(
                  Icons.file_upload,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ));
  }

  

  void getSlides() {
    var alert = GestureDetector(
      child: Icon(Icons.home,color: Colors.white,),
      onTap: () {
        showDialog<bool>(
            context: context,
            builder: (_) {
              return AlertDialog(
                content:
                    Text("Are you sure you want to return to Home Page? "),
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
                      SaveProgress.preferences(widget.modNum, widget.index);

                      // Navigator.of(context).popUntil(ModalRoute.withName("/QuoteLoading"));
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
    );
    List<Page> page = widget.pages;

    print("Length of pages" + page.length.toString());

    for (var i = 0; i < page.length - 1; i++) {
      var item = page[i];
      String body = "";
      for (var line in item.body.split(". ")) {
        body += line + "\n\n";
      }
      //  print("body = "+body);
      slides.add(
        new Container(
          alignment: Alignment.topCenter,
          color: Colors.green,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
               Padding(
                 padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.1,top:MediaQuery.of(context).size.height*0.05),
                 child:  Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                       alert,
                    ],
                ),
               ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.05),
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      item.headding,
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
               

                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      body,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        // fontWeight: FontWeight.,
                      ),
                    ),
                  ),
                ),
                Material(
                    color: Colors.transparent,
                    child: Text(
                      "Swipe for Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        // fontWeight: FontWeight.,
                      ),
                    )),
                //  pathImage: "images/photo_eraser.png",
              ],
            ),
          ),
        ),
      );
    }
    var item = page[page.length - 1];
    String body = "";
    for (var line in item.body.split(". ")) {
      body += line + "\n\n";
    }
    slides.add(
      new Container(
        alignment: Alignment.topCenter,
        color: Colors.green,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
               Padding(
                 padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.1,top:MediaQuery.of(context).size.height*0.05),
                 child:  Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                       alert,
                    ],
                ),
               ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.05),
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    item.headding,
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    body,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      // fontWeight: FontWeight.,
                    ),
                  ),
                ),
              ),
              renderDoneBtn()
              //  pathImage: "images/photo_eraser.png",
            ],
          ),
        ),
      ),
    );
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

  // Future onDonePress() async {
  //   //  File file1  = await FilePicker.getFile(type: FileType.ANY);
  //   // String filePath = await FilePicker.getFilePath(type: FileType.ANY);
  //   //  print("File picked successfully"+filePath);
  //   //  setState(() {
  //   //   //file = file1;
  //   //   //print("File Picker File name inside = "+p.basename(file.path));
  //   //  });
  //   //print("File Picker File name = "+p.basename(file.path));
  //   // Do what you want
  // }

  Future upload(file) async {
   FirebaseUser user = await FirebaseAuth.instance.currentUser();
   this.uid = user.uid;
   String name = await User.getUserName(uid);
    String extenstion = p.basename(file.path).split(".")[1];
    final StorageReference storageRef = FirebaseStorage.instance
        .ref()
         .child("userUpload")
       .child("${uid}_${name}")
        .child("${widget.modNum}_activity_${widget.index}." + extenstion);

    task = storageRef.putFile(file);
    //  if(task.isInProgress){
    //    print("On Progress task");

    StorageTaskSnapshot taskSnapshot = await task.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
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

  Future<String> get status async {
    String result;
    if (task.isComplete) {
      if (task.isSuccessful) {
        await task.lastSnapshot.ref.getDownloadURL();
        // var file = FileData(task.lastSnapshot.ref.toString(),
        //     task.lastSnapshot.storageMetadata.name, url);
        result = 'Complete' + task.lastSnapshot.ref.toString();
        // firebaseStorage.addUser(file);
      } else if (task.isCanceled) {
        result = 'Canceled';
      } else {
        result = 'Failed ERROR: ${task.lastSnapshot.error}';
      }
    } else if (task.isInProgress) {
      result = 'Uploading';
    } else if (task.isPaused) {
      result = 'Paused';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // return new IntroSlider(
    //   slides: this.slides,

    //   onDonePress: getFilePath, //this.onDonePress,
    //   renderSkipBtn: Text(" "),
    //   renderDoneBtn: this.renderDoneBtn(),
    //   sizeDot: 0,
    // );
    getSlides();
    return CustomeOffline(
          onConnetivity: PageView(
        children: this.slides,
      ),
    );
  }
}
