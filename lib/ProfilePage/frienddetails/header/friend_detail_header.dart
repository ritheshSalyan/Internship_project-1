import 'package:flutter/material.dart';
import 'package:startupreneur/ModulePages/UserDetail.dart';
import '../../friends/friend.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:startupreneur/progress_dialog/progress_dialog.dart';
import '../../ProfilePageLoader.dart';

class FriendDetailHeader extends StatelessWidget  {
  static const BACKGROUND_IMAGE = 'assets/Images/profile_header_background.png';

  FriendDetailHeader({
    this.friend,
    this.context,
  });
   File file;
  final Friend friend;
  final BuildContext context;
 
  static ProgressDialog progressDialog;
  void getFilePath(BuildContext context) async {
    //  String _filePath;
    try {
     
       print("Before File picked ");
      var file1 = await FilePicker.getFile(type: FileType.IMAGE).timeout(Duration(seconds: 10));
      // var file1 = await ImagePicker.pickImage(source: ImageSource.gallery);
      
      print("File picked successfully");
       progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
      progressDialog.setMessage("Uploading....");
      progressDialog.show();
      if (file1 == null) {
        progressDialog.hide();
        return;
      }
      this.file = file1;
      print("File path: " + p.basename(file1.path));
      // setState(() {
      //   file = file1;
      // });
      upload();
    } catch (e) {
      print("Error while picking the file: " + e.toString());
      progressDialog.hide();
    }
  }

  Future upload() async {
    // FirebaseAuth.instance.currentUser().then((user) {
    //   this.uid = user.uid;
    // });
    fs.Firestore firestore = fb.firestore();
    String extenstion = p.basename(file.path).split(".")[1];
    
     String name = await User.getUserName(friend.uid);
   
    final fb.StorageReference storageRef =  fb.storage()
        .ref()
         .child("userUpload")
       .child("${friend.uid}_${name}")
        .child("profile." + extenstion);

    var task = storageRef.put(file);
    //  if(task.isInProgress){
    //    print("On Progress task");

    // StorageTaskSnapshot taskSnapshot = await task.onComplete;
    var data = await task.future;
    String downloadUrl = await data.ref.getDownloadURL().toString();
    print("On downloadUrl task" + downloadUrl);

    var dataMap = new Map<String, dynamic>();
    dataMap['profile'] = downloadUrl;

    await firestore
        .collection("user")
        .doc(friend.uid)
        .set(dataMap, fs.SetOptions(merge: true))
        .catchError((e) {
      progressDialog.hide();
      print(e);
    });
    
    print("Hai");
    progressDialog.hide();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => new ProfileLoading(uid: friend.uid),
    ));
       
  }

  Widget _buildAvatar() {
    return new GestureDetector(
      onTap: () {
        // getFilePath(context);
      },
      child: new Hero(
        tag: 1,
        child: new CircleAvatar(
//          backgroundImage: new NetworkImage(friend.avatar),
            backgroundImage: NetworkImage(friend.avatar),
          radius: 65.0,
          child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.14,
                  left: MediaQuery.of(context).size.width * 0.15),
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  getFilePath(context);
                },
              )),
        ),
      ),
    );
  }

  Widget _buildFollowerInfo(TextTheme textTheme) {
    // var followerStyle =
    //     textTheme.subhead.copyWith(color: const Color(0xBBFFFFFF));

    return new Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: new Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //  new Text('90 Following', style: followerStyle),
          Column(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(friend.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 2,
                        fontFamily: "Open Sans",
                        color: Colors.white)),
              ),
            ],
          ),
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            child: Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.32),
              child:
                Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/Images/coins.png",
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    new Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(friend.points.toString(),
                      textAlign: TextAlign.center,
                          style: TextStyle(
                            
                              fontSize: 20,
                              letterSpacing: 2,
                              fontFamily: "Open Sans",
                              color: Colors.white)),
                    ),
                  ],
                ),
             
            ),
          ),
          // new Text('100 Followers', style: followerStyle),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return new Stack(
      children: <Widget>[
        // _buildDiagonalImageBackground(context),
        new Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.4,
          child: new Column(
            children: <Widget>[
              _buildAvatar(),
              _buildFollowerInfo(textTheme),
            ],
          ),
        ),
        new Positioned(
          top: 26.0,
          left: 4.0,
          child: new BackButton(color: Colors.black),
        ),
      ],
    );
  }
}
