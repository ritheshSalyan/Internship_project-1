import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';


class Internships {
  String name;
  String description;
  String role;
  String logo;
  dynamic compensation;
  String duration;
  String location;
  String type;

  Internships({
    this.name,
    this.description,
    this.role,
    this.duration,
    this.logo,
    this.compensation,
    this.location,
    this.type,
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
//    doc = await PDFDocument.fromAsset("S:\\Flutter_projects\\startupreneur\\assets\\pdf\\t_and_c.pdf");

    await db.collection("user").document(UserId).get().then((document){
        resumeDownload  = document.data["resume"];
        print(resumeDownload);
    });
    String uri = Uri.decodeFull(resumeDownload);
    final RegExp regex = RegExp('([^?/]*\.(pdf))');
    fileName = regex.stringMatch(uri);
    tempDir = Directory.systemTemp;
    file = File('${tempDir.path}/$fileName');
    print("File path ${tempDir.absolute}");
    storageReference = FirebaseStorage.instance.ref().child(UserId).child(fileName);
    storageReference.getDownloadURL().then((link){
      print(link);
    });
    final StorageFileDownloadTask downloadTask = storageReference.writeToFile(file);
    print(downloadTask);
    final int byteNumber = (await downloadTask.future).totalByteCount;
    print(byteNumber);
  }

  _launchURL(String toMailId, String subject, String body,File file) async {

    try{
      await platform.invokeMethod("sendEmail",{"toMail":toMailId,"subject":subject,"body":body,"attachment":file.path});
    }
    on PlatformException catch(e){
      print(e);
    }
  }

  List<Widget> listGenerated(
      var lengthVal, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              _launchURL("subramanyarao4@gmail.com","Simple mail","Jobless",file);
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

  List<Widget> expansionGeneration(AsyncSnapshot<QuerySnapshot> snapshot) {
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
                              duration: document.data["duration"],
                              location: document.data["location"],
                              compensation: document.data["compensation"],
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
