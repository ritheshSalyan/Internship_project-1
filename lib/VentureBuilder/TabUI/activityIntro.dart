import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart';
import 'dart:html' as html;
import 'package:startupreneur/ModulePages/UserDetail.dart' as u;
import 'package:toast/toast.dart';

class ActivityIntro extends StatefulWidget {
  ActivityIntro({
    this.intro,
    this.heading,
    this.index,
    this.modName,
    this.modNum,
    this.files,
    this.buttons,
    this.btnLength,
  });
  List intro, heading, buttons;
  int index, btnLength;
  dynamic files;
  dynamic modNum, modName;
  @override
  _ActivityIntroState createState() => _ActivityIntroState();
}

class _ActivityIntroState extends State<ActivityIntro> {
  @override
  void initState() {
    super.initState();
    print(widget.index);
  }

  String uid;
  List<int> _selectedFile;
  Uint8List _bytesData;
  fb.UploadTask _uploadTask;

  Future upload(html.File file) async {
    Auth auth = fb.auth();
    var user = auth.currentUser;
    this.uid = user.uid;

    print("file is $file");

    String name = await u.User.getUserName(uid);
    print(file.name.split('.'));
    String extension = file.name.split('.')[1];
    String filePath = 'userUpload/VentureBuilder/';

    setState(() {
      _uploadTask = fb
          .storage()
          .refFromURL('gs://thestartupreneur-e1201.appspot.com')
          .child(filePath)
          .child("${uid}_${name}")
          .child("${DateTime.now()}_upload." + extension)
          .put(file);
    });

    // var task = storageRef.put(file);
    var taskSnapshot = await _uploadTask.future;
    taskSnapshot.ref.getDownloadURL().then((data) {
      print(data);
    });
    // print("On downloadUrl task" + downloadUrl);
    Toast.show("Your Activity Uploaded Successfully", context,
        gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
  }

  void getFilePath() async {
    //  String _filePath;
    try {
      html.InputElement uploadInput = html.FileUploadInputElement();
      uploadInput.multiple = true;
      uploadInput.draggable = true;
      uploadInput.click();
      uploadInput.onChange.listen((e) async {
        final files = uploadInput.files;
        final file = files[0];
        final reader = new html.FileReader();

        print("file is $file");

        await upload(file);

        reader.onLoadEnd.listen((e) {
          _handleResult(reader.result);
        });
        reader.readAsDataUrl(file);
      });
    } catch (e) {
      Toast.show("Upload failed, please try again", context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      print("Error while picking the file: " + e.toString());
    }
  }

  void _handleResult(Object result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
  }

  void downloadFile() async {
    var request = await http.Request('GET', Uri.parse(widget.files));  
    request.headers['Access-Control-Allow-Origin'] = '*';
    await request.send();

    print(request.body);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          // width: MediaQuery.of(context).size.width * 0.8,
                          // height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: AutoSizeText(
                            "${widget.heading[widget.index]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            minFontSize: 20,
                            maxFontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: AutoSizeText(
                        "${widget.intro[widget.index]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.1,
                        ),
                        minFontSize: 18,
                        maxFontSize: 25,
                        maxLines: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  (widget.buttons[widget.index] != null &&
                          widget.buttons[widget.index].isNotEmpty)
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            // alignment: Alignment.center,
                            onPressed: () {
                              if (widget.index == widget.btnLength - 1) {
                                print("inside if ");
                                getFilePath();
                              } else {
                                print("inside else ");
                                if (widget.index == widget.btnLength - 2) {
                                  downloadFile();
                                }
                              }
                            },
                            child: AutoSizeText(
                              "${widget.buttons[widget.index]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.1,
                              ),
                              minFontSize: 18,
                              maxFontSize: 25,
                              maxLines: 15,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
