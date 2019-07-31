import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'Page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:startupreneur/progress_dialog/progress_dialog.dart';
import '../../ModuleOrderController/Types.dart';
//import 'package:intro_slider_example/home.dart';

class FileUpload extends StatefulWidget {
  FileUpload({Key key, this.modNum, this.index, this.pages}) : super(key: key);
  int modNum, index;
  List<Page> pages;
  @override
  FileUploadState createState() => new FileUploadState();
}

//------------------ Default config ------------------
class FileUploadState extends State<FileUpload> {
  List<Slide> slides = new List();

  File file;
  String uid;
  static ProgressDialog progressDialog;
  StorageUploadTask task;
  Widget renderDoneBtn() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:OutlineButton(
        onPressed: (){
          getFilePath();
        },
        child:  Row(
        children: <Widget>[
          Text(
            "Upload",
            style: TextStyle(color: Colors.white),
          ),
          Icon(Icons.file_upload)
        ],
      ),
      )
    );
  }

  @override
  void initState() {
    super.initState();

    List<Page> page = null;
    page = widget.pages;

    print("Length of pages" + page.length.toString());

    for (var item in page) {
      String body = "";
      for (var line in item.body.split(". ")) {
        body += line + "\n\n";
      }
      //  print("body = "+body);
      slides.add(
        new Slide(
          title: item.headding,
          maxLineTitle: 4,
          styleTitle: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
          description: body,
          styleDescription: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            // fontWeight: FontWeight.,
          ),
          //  pathImage: "images/photo_eraser.png",
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void getFilePath() async {
   
    //  String _filePath;
    try {
      // String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      File file1 = await FilePicker.getFile(type: FileType.ANY);
       progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
    progressDialog.setMessage("Uploading....");
    progressDialog.show();
      print("File picked successfully");
      if (file1 == null) {
        return;
      }
      print("File path: " + p.basename(file1.path));
      setState(() {
        file = file1;
      });
      upload();
    } catch (e) {
      progressDialog.hide();
      print("Error while picking the file: " + e.toString());
    }
  }

  Future onDonePress() async {
    //  File file1  = await FilePicker.getFile(type: FileType.ANY);
    // String filePath = await FilePicker.getFilePath(type: FileType.ANY);
    //  print("File picked successfully"+filePath);
    //  setState(() {
    //   //file = file1;
    //   //print("File Picker File name inside = "+p.basename(file.path));
    //  });
    //print("File Picker File name = "+p.basename(file.path));
    // Do what you want
  }

  Future upload() async{
    FirebaseAuth.instance.currentUser().then((user) {
      this.uid = user.uid;
    });
    String extenstion = p.basename(file.path).split(".")[1];
    final StorageReference storageRef = FirebaseStorage.instance
        .ref()
        .child(uid)
        .child("${widget.modNum}_activity." + extenstion);

    task = storageRef.putFile(file);
    //  if(task.isInProgress){
    //    print("On Progress task");

StorageTaskSnapshot taskSnapshot = await task.onComplete;
String downloadUrl = await taskSnapshot.ref.getDownloadURL();
print("On downloadUrl task"+downloadUrl);
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
        String url = await task.lastSnapshot.ref.getDownloadURL();
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
    return new IntroSlider(
      slides: this.slides,

      onDonePress: getFilePath, //this.onDonePress,
      renderDoneBtn: this.renderDoneBtn(),
      sizeDot: 0,
    );
  }
}

// class UploadProgressWidget extends StatelessWidget {
//   final StorageUploadTask task;
//   // final FirebaseDatabaseUtil firebaseStorage;
//   const UploadProgressWidget({Key key, this.task,})
//       : super(key: key);

//   Future<String> get status async {
//     String result;
//     if (task.isComplete) {
//       if (task.isSuccessful) {
//         String url = await task.lastSnapshot.ref.getDownloadURL();
//         // var file = FileData(task.lastSnapshot.ref.toString(),
//         //     task.lastSnapshot.storageMetadata.name, url);
//         result = 'Complete' + task.lastSnapshot.ref.toString();
//        // firebaseStorage.addUser(file);
//       } else if (task.isCanceled) {
//         result = 'Canceled';
//       } else {
//         result = 'Failed ERROR: ${task.lastSnapshot.error}';
//       }
//     } else if (task.isInProgress) {
//       result = 'Uploading';
//     } else if (task.isPaused) {
//       result = 'Paused';
//     }
//     return result;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<StorageTaskEvent>(
//       stream: task.events,
//       builder: (BuildContext context,
//           AsyncSnapshot<StorageTaskEvent> asyncSnapshot) {
//         print('$status:uploading');
//         return Dismissible(
//           key: Key(task.hashCode.toString()),
//           child: new Row(
//             children: <Widget>[new CircularProgressIndicator()],
//           ),
//         );
//       },
//     );
//   }
// }
