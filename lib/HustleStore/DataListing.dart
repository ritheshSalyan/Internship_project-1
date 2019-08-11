import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../progress_dialog/progress_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar.dart';


class Internships {
  String name;
  String description;
  String role;
  String logo;
  dynamic compensation;
  String duration;
  String location;
  String type;
  String email;

  Internships({
    this.name,
    this.description,
    this.role,
    this.duration,
    this.logo,
    this.compensation,
    this.location,
    this.type,
    this.email,
  });
}

class ListingData extends StatefulWidget {
  ListingData({Key key, this.title, this.index}) : super(key: key);
  String title;
  int index;

  @override
  _ListingDataState createState() => _ListingDataState();
}

class _ListingDataState extends State<ListingData> {
  List<Internships> list = [];
  dynamic dataSnapshot;
  Firestore db = Firestore.instance;
  SharedPreferences sharedPreferences;
  String UserId;
  String resumeDownload;
  PDFDocument doc;
  String fileName;
  static const platform  = MethodChannel("email");
  StorageReference storageReference;
   Directory tempDir;
   File file;
   ProgressDialog progressDialog ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preferences();
    if (widget.index == 1) {
      widget.title = "incubation";
    } else {
      widget.title = "Internship";
    }
  }

  void preferences() async{
    sharedPreferences = await SharedPreferences.getInstance();
    UserId = sharedPreferences.getString("UserId");
    final dir = (await getExternalStorageDirectory()).path;
    print("File path ${dir}");
//    doc = await PDFDocument.fromAsset("S:\\Flutter_projects\\startupreneur\\assets\\pdf\\t_and_c.pdf");
  }


  _launchURL(String toMailId, String subject, String body,File file,BuildContext context) async {

    progressDialog = ProgressDialog(context,ProgressDialogType.Normal);
    progressDialog.setMessage("Please wait");
    try{
      progressDialog.show();
      await db.collection("user").document(UserId).get().then((document){
        resumeDownload  = document.data["resume"];
        print(resumeDownload);
      });
      if(resumeDownload == ""){
        progressDialog.hide();
        return Flushbar(
          isDismissible: true,
          duration: Duration(seconds:3),
          title: "Warning!",
          message: "Seems like you have not uploaded your Resume`! Please upload your resume to continue.",
        )..show(context);
      }
      String uri = Uri.decodeFull(resumeDownload);
      final RegExp regex = RegExp('([^?/]*\.(pdf))');
      fileName = regex.stringMatch(uri);
//      progressDialog.update(message: "Loading Resume`");
      tempDir = Directory.systemTemp;
      file = File('${tempDir.path}/$fileName');

      storageReference = FirebaseStorage.instance.ref().child(UserId).child(fileName);
      storageReference.getData(1000000).then((link){
        print(link);
      });
      progressDialog.update(message: "Preparing Mail Server");
      final StorageFileDownloadTask downloadTask = storageReference.writeToFile(file);
      final int byteNumber = (await downloadTask.future).totalByteCount;
      print(byteNumber);
      print("done");
      progressDialog.hide();
      await platform.invokeMethod("sendEmail",{"toMail":toMailId,"subject":subject,"body":body,"attachment":resumeDownload,"filename":fileName});
    }
    on PlatformException catch(e){
      print(e);
    }
  }



  List<Widget> listGenerated(
      var lengthVal, AsyncSnapshot<QuerySnapshot> snapshot,BuildContext context) {
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
          leading: Text("Role"),
          title: Text("${list[lengthVal].role}"),
        ),
        ListTile(
          leading: Text("Type"),
          title: Text("${list[lengthVal].type}"),
        ),
        ListTile(
          leading: Text("Duration"),
          title: Text("${list[lengthVal].duration}"),
        ),
        ListTile(
          leading: Text("Location"),
          title: Text("${list[lengthVal].location}"),
        ),
        ListTile(
          leading: Text("Compensation"),
          title: Text("${list[lengthVal].compensation}"),
        ),
        ListTile(
          leading: Text("Email"),
          title: Text("${list[lengthVal].email}"),
        ),
      ],
    ));
    listWidget.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: OutlineButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            borderSide: BorderSide(color: Colors.green, width: 1.5),
            onPressed: () {
              _launchURL(list[lengthVal].email,"Trial mail","Trial Mail",file,context);
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
            onPressed: () {},
            child: Text("View docs"),
          ),
        ),
      ],
    ));
//    print(listWidget);
    return listWidget;
  }



  List<Widget> expansionGeneration(AsyncSnapshot<QuerySnapshot> snapshot,BuildContext context) {
    List<Widget> value = [];
    print("value of list ${list.length}");
    for (int i = 0; i < list.length; i++) {
      value.add(ExpansionTile(
        leading: CircleAvatar(
          child: Image.asset(list[i].logo),
        ),
        title: Text("${list[i].name}"),
        children: listGenerated(i, snapshot,context),
      ));
    }
    return value;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.replaceAll("\n", " ")),
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
                StreamBuilder<QuerySnapshot>(
                    stream:
                        Firestore.instance.collection("Internship").snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      switch (snapshot.data) {
                        case null:
                          print("hello null");
                          return CircularProgressIndicator();
                        default:
                          list.clear();
                          snapshot.data.documents.forEach((document) {
                            dataSnapshot = document;
                            list.add(new Internships(
                              name: document.data["name"],
                              description: document.data["description"],
                              type: document.data["type"],
                              role: document.data["role"],
                              logo: document.data["logo"],
                              email: document.data["email"],
                              duration: document.data["duration"],
                              location: document.data["location"],
                              compensation: document.data["compensation"],
                            ));
                          });
//                          print(list);
                          return Column(
                            children: expansionGeneration(snapshot,context),
                          );
                      }
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
