import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
// import 'package:url_launcher/url_launcher.dart' as l;
import 'package:url_launcher/url_launcher.dart';
import '../../progress_dialog/progress_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar.dart';
import '../ViewDocs/ViewDocs.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs ;

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
  List<dynamic> docs;

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
    this.docs,
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
  fs.Firestore db = fb.firestore();
  SharedPreferences sharedPreferences;
  String UserId;
  String resumeDownload;
  PDFDocument doc;
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
    if (widget.index == 1) {
      widget.title = "incubation";
    } else {
      widget.title = "Internship";
    }

    // Analytics.analyticsBehaviour("internship_Offer_Page", "Internship_Page");
  }

  void preferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    UserId = sharedPreferences.getString("UserId");
  }

  _launchURL(String toMailId) async {
    var url = 'mailto:$toMailId';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<Widget> listGenerated(var lengthVal,
      AsyncSnapshot<fs.QuerySnapshot> snapshot, BuildContext context) {
    List<Widget> listWidget = new List<Widget>();
    listWidget.add(
      Column(
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
            leading: Text("Contact Email"),
            title: Text("${list[lengthVal].email}"),
          ),
        ],
      ),
    );

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
              onPressed: () async{
               await  _launchURL(list[lengthVal].email);
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ViewDocs(
                      lengthList: list[lengthVal].docs.length,
                      doc: list[lengthVal].docs,
                    ),
                  ),
                );
              },
              child: Text("View docs"),
            ),
          ),
        ],
      ),
    );
    return listWidget;
  }

  List<Widget> expansionGeneration(
      AsyncSnapshot<fs.QuerySnapshot> snapshot, BuildContext context) {
    List<Widget> value = [];
    print("value of list ${list.length}");
    for (int i = 0; i < list.length; i++) {
      value.add(ExpansionTile(
        leading: CircleAvatar(
          child: Image.asset(list[i].logo),
        ),
        title: Text("${list[i].name}"),
        children: listGenerated(i, snapshot, context),
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
              "More Internships and Projects coming soon! Stay Tuned",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,),
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
        title: Text("Internships"),
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
                StreamBuilder<fs.QuerySnapshot>(
                  stream:
                     db.collection("Internship").onSnapshot,
                  builder: (context, AsyncSnapshot<fs.QuerySnapshot> snapshot) {
                    switch (snapshot.data) {
                      case null:
                        print("hello null");
                        return CircularProgressIndicator();
                      default:
                        list.clear();
                        snapshot.data.docs.forEach(
                          (document) {
                            dataSnapshot = document;
                            list.add(
                              new Internships(
                                name: document.data()["name"],
                                description: document.data()["description"],
                                type: document.data()["type"],
                                role: document.data()["role"],
                                logo: document.data()["logo"],
                                email: document.data()["contactEmail"],
                                duration: document.data()["duration"],
                                location: document.data()["location"],
                                compensation: document.data()["compensation"],
                                docs: document.data()["document"],
                              ),
                            );
                          },
                        );
                        return Column(
                          children: expansionGeneration(snapshot, context),
                        );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
