import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:startupreneur/ModuleOrderController/Types.dart';
import 'package:startupreneur/NoInternetPage/NoNetPage.dart';
import 'package:startupreneur/globalKeys.dart';
import 'package:startupreneur/progress_dialog/progress_dialog.dart';
import 'package:startupreneur/saveProgress.dart';

class IdeaActivity extends StatefulWidget {
  IdeaActivity({Key key, this.modNum, this.index}) : super(key: key);
  final int modNum, index;
  @override
  _IdeaActivityState createState() => _IdeaActivityState();
}

class _IdeaActivityState extends State<IdeaActivity> {
  static String name, idea, grow, person;
  final GlobalKey<FormState> box1 = GlobalKey<FormState>();
  final GlobalKey<FormState> box2 = GlobalKey<FormState>();
  final GlobalKey<FormState> box3 = GlobalKey<FormState>();
  final GlobalKey<FormState> box4 = GlobalKey<FormState>();

  bool _validateFromBox1() {
    final form = box1.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool validateFormBox1(BuildContext context) {
    if (_validateFromBox1()) {
      return true;
    }
    return false;
  }

  bool _validateFromBox2() {
    final form = box2.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool validateFormBox2(BuildContext context) {
    if (_validateFromBox2()) {
      return true;
    }
    return false;
  }

  bool _validateFromBox3() {
    final form = box3.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool validateFormBox3(BuildContext context) {
    if (_validateFromBox3()) {
      return true;
    }
    return false;
  }

  bool _validateFromBox4() {
    final form = box4.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool validateFormBox4(BuildContext context) {
    if (_validateFromBox4()) {
      return true;
    }
    return false;
  }

  ProgressDialog progressDialog;
  @override
  Widget build(BuildContext context) {
    print("*************************************${widget.index}");
    return OfflineBuilder(
      child: NoNetPage(),
      connectivityBuilder: (contex, connection, child) {
        final connected = connection != ConnectivityResult.none;
        if (connected) {
          child = Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                bottom: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Page ${widget.index + 1}/${Module.moduleLength}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              actions: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.home,
                    color: Colors.green,
                  ),
                  onTap: () {
                    showDialog<bool>(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            content: Text(
                                "Are you sure you want to return to home Page?? "),
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
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        "Then document your team’s idea by answering the questions below:",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Form(
                            key: box1,
                            child: TextFormField(
                              // key: _formKey,
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Name field cannot be empty";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                name = value;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.supervised_user_circle,
                                  color: Colors.green,
                                ),
                                hintText: "  ",
                                labelText:
                                    "Name (Add Team Members if applicable)",
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    letterSpacing: 0.5),
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    letterSpacing: 0.5),
                              ),
                            ),
                          ),
                          Form(
                            key: box2,
                            child: TextFormField(
                              // key: _formKey,
                              // autovalidate: true,
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Bussiness Idea field cannot be empty";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                idea = value;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.info_outline,
                                  color: Colors.green,
                                ),
                                hintText: " ",
                                labelText:
                                    "What is your Business Idea: How is it differentiated?",
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    letterSpacing: 0.5),
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          Form(
                            key: box3,
                            child: TextFormField(
                              // key: _formKey,
                              // autovalidate: true,
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Description field cannot be empty";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                grow = value;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.show_chart,
                                  color: Colors.green,
                                ),
                                hintText: " ",
                                labelText:
                                    "What will it take to grow the business?",
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    letterSpacing: 0.5),
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    letterSpacing: 0.5),
                              ),
                            ),
                          ),
                          Form(
                            key: box4,
                            child: TextFormField(
                              // key: _formKey,
                              // autovalidate: true,
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "This field cannot be empty";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                person = value;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.question_answer,
                                  color: Colors.green,
                                ),
                                hintText: " ",
                                labelText:
                                    "Why are you the person/team to do it?",
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    letterSpacing: 0.5),
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    letterSpacing: 0.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    OutlineButton(
                      child: Text("Upload"),
                      onPressed: () async {
                        bool b1 = validateFormBox1(context);
                        bool b2 = validateFormBox2(context);
                        bool b3 = validateFormBox3(context);
                        bool b4 = validateFormBox4(context);

                        if (b1 && b2 && b3 && b4) {
                          progressDialog = new ProgressDialog(
                              context, ProgressDialogType.Normal);
                          progressDialog.setMessage("Uploading....");
                          print(
                              "*****************************************************INdex here ${widget.index}");
                          progressDialog.show();
                          await getFile();
                          List<dynamic> arguments = [widget.modNum, 32 + 1];
                          orderManagement.moveNextIndex(context, arguments);
                          progressDialog.hide();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return child;
      },
    );
  }

  static void getFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("userUpload")
        .child("ActivityUpload/Idea.csv");
    await downloadFile(storageReference);
  }

  static Future<void> downloadFile(StorageReference ref) async {
    final String url = await ref.getDownloadURL();
    // final http.Response downloadData = await http.get(url);
    final Directory systemTempDir = Directory.systemTemp;
    final File tempFile = File('${systemTempDir.path}/tmp.csv');
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
    await tempFile.create();
    final StorageFileDownloadTask task = ref.writeToFile(tempFile);
    final int byteCount = (await task.future).totalByteCount;
    // var bodyBytes = downloadData.bodyBytes;
    final String name1 = await ref.getName();
    final String path = await ref.getPath();
    final String stri = await tempFile.readAsString();
    print(
      'Success!\nDownloaded $name1 \nUrl: $url'
      '\npath: $path \nBytes Count :: $byteCount\n${stri}',
    );
    tempFile.writeAsString("$name,$idea,$person,$grow\n",
        flush: false, mode: FileMode.APPEND);
    upload(ref, tempFile);

    // _scaffoldKey.currentState.showSnackBar(
    //   SnackBar(
    //     backgroundColor: Colors.white,
    //     content: Image.memory(
    //       bodyBytes,
    //       fit: BoxFit.fill,
    //     ),
    //   ),
    // );
  }

  static void upload(storageRef, file) {
    // var _extension = fileName.toString().split('.').last;
    storageRef.putFile(file);
  }
}
