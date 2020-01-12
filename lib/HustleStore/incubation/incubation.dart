import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs ;
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:startupreneur/HustleStore/ViewDocs/ViewDocs.dart';
import 'package:startupreneur/ModulePages/UserDetail.dart';
import 'package:startupreneur/progress_dialog/progress_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Internships {
  String name;
  String description;
  String logo;
  dynamic sector;
  String email;
  String location;
  List<dynamic> doc;

  Internships({
    this.name,
    this.description,
    this.email,
    this.logo,
    this.sector,
    this.location,
    this.doc,
  });
}

class Incubation extends StatefulWidget {
  Incubation({Key key, this.title}) : super(key: key);
  String title;

  @override
  _IncubationState createState() => _IncubationState();
}

class _IncubationState extends State<Incubation> {
  List<Internships> list = [];
  dynamic dataSnapshot;
  fs.Firestore db = fb.firestore();
  SharedPreferences sharedPreferences;
  String UserId;
  String resumeDownload;
  String fileName;
  static const platform = MethodChannel("email");
  StorageReference storageReference;
  Directory tempDir;
  File file;
  bool status = false;
  ProgressDialog progressDialog;

  @override
  void initState() {

    super.initState();
    preferences();
    status = false;

    // Analytics.analyticsBehaviour("Incubation_Hustle_Store", "incubation_Hustle");
  }

  void preferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    UserId = sharedPreferences.getString("UserId");
  }

  _launchURL(String toMailId, String subject, String body, File file,
      BuildContext context) async {
    progressDialog = ProgressDialog(context, ProgressDialogType.Normal);
    progressDialog.setMessage("Please wait");
    try {
      progressDialog.show();
      await db.collection("user").doc(UserId).get().then((document) {
        resumeDownload = document.data()["resume"];
        print(resumeDownload);
      });
      if (resumeDownload == "") {
        progressDialog.hide();
        return Flushbar(
          isDismissible: true,
          duration: Duration(seconds: 3),
          title: "Warning!",
          message:
              "Seems like you have not uploaded your Resume`! Please upload your resume to continue.",
        )..show(context);
      }
      String uri = Uri.decodeFull(resumeDownload);
      final RegExp regex = RegExp('([^?/]*\.(pdf|jpg|txt|docx|zip|jpeg|png|csv))');
      fileName = regex.stringMatch(uri);
//      progressDialog.update(message: "Loading Resume`");
      tempDir = Directory.systemTemp;
      final dir =(await getExternalStorageDirectory()).path;
      print("File path $dir");
      file = File('$dir/$fileName');
      print(file.path);
      print(UserId);
     
      storageReference =
          FirebaseStorage.instance.ref().child(UserId).child(fileName);
      progressDialog.update(message: "Preparing Mail Server");
      final StorageFileDownloadTask downloadTask =
          storageReference.writeToFile(file);
      final int byteNumber = (await downloadTask.future).totalByteCount;
      print(byteNumber);
      print("done");
      progressDialog.hide();
      await platform.invokeMethod("sendEmail", {
        "toMail": toMailId,
        "subject": subject,
        "body": body,
        "attachment": file.path,
        "filename": fileName
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  List<Widget> listGenerated(
      var lengthVal, AsyncSnapshot snapshot) {
//    print("${lengthVal}");
    List<Widget> listWidget = new List<Widget>();
    listWidget.add(Column(
      children: <Widget>[
        ListTile(
          leading: Text("Name"),
          title: Text("${list[lengthVal].name}"),
        ),
        ListTile(
          leading: Text("Description"),
          title: Text("${list[lengthVal].description}"),
        ),
        ListTile(
          leading: Text("Sector"),
          title: Text("${list[lengthVal].sector}"),
        ),
        ListTile(
          leading: Text("Location"),
          title: Text("${list[lengthVal].location}"),
        ),
        ListTile(
          leading: Text("Contact Email"),
          title: Text("${list[lengthVal].email}"),
        ),
      ],
    ));
    listWidget.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              borderSide: BorderSide(color: Colors.green, width: 1.5),
              onPressed: () {
                _launchURL(list[lengthVal].email, "Trial mail", "Trial Mail",
                    file, context);
              },
              child: Text("Apply"),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              borderSide: BorderSide(color: Colors.green, width: 1.5),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewDocs(
                          lengthList: list[lengthVal].doc.length,
                          doc: list[lengthVal].doc,
                        )));
              },
              child: Text("View docs"),
            ),
          ),
        ],
      ),
    );
//    print(listWidget);
    return listWidget;
  }

  List<Widget> expansionGeneration(AsyncSnapshot snapshot) {
    List<Widget> value = [];
    print("value of list ${list.length}");

    for (int i = 0; i < list.length; i++) {
      value.add(ExpansionTile(
        leading: CircleAvatar(
          child: Image.asset(list[i].logo),
        ),
        title: Text("${list[i].name}"),
        children: listGenerated(i, snapshot),
      ));
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!status) {
      Flushbar(
        title: "Note: ",
        backgroundColor: Colors.green,
        messageText: Column(
          children: <Widget>[
            Text(
              "More Incubators coming soon! Stay Tuned",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            OutlineButton(
              color: Colors.black,
              onPressed: () {
                setState(() {
                 status = true; 
                });
                Navigator.of(context).pop();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "OK",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        // duration: Duration(seconds: 5),
      )..show(context);
      // setState(() {
      //   widget.status = false;
      // });
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Card(
                    elevation: 3.0,
                    child: Text(
                      "Details about it",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                StreamBuilder(
                    stream:
                        db.collection("incubation").onSnapshot,
                    builder: (context, AsyncSnapshot<fs.QuerySnapshot> snapshot) {
                      switch (snapshot.data) {
                        case null:
                          print("hello null");
                          return CircularProgressIndicator();
                        default:
                          list.clear();
                          snapshot.data.docs.forEach((document) {
                            dataSnapshot = document;

                            list.add(new Internships(
                              name: document.data()["name"],
                              description: document.data()["about"],
                              logo: document.data()["logo"],
                              location: document.data()["location"],
                              sector: document.data()["sector"],
                              email: document.data()["email"],
                              doc: document.data()["document"],
                            ));
                          });
//                          print(list);
                          return Column(
                            children: expansionGeneration(snapshot),
                          );
                      }
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}
