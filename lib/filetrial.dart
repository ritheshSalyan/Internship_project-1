import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileTest extends StatefulWidget {
  @override
  _FileTestState createState() => _FileTestState();
}

class _FileTestState extends State<FileTest> {
  String filePath = "Hello";

  void getFile() async {
    print("Before Picking File");
    File file = await FilePicker.getFile(type: FileType.ANY);
    setState(() {
      filePath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("Upload"),
                onPressed: getFile,
              ),
              Text(filePath),
            ],
          )),
    );
  }
}
