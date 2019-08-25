import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'FileUpload.dart';
import '../../ModuleOrderController/Types.dart';
import 'Page.dart';

class FileUploadLoading extends StatefulWidget {
  FileUploadLoading({Key key, this.modNum, this.index}) : super(key: key);
  final int modNum, index;
  @override
  _FileUploadLoading createState() => _FileUploadLoading();
}

class _FileUploadLoading extends State<FileUploadLoading> {
  static final List<String> words = [];
  static final List<String> meanings = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.modNum).then((title) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => FileUpload(
            index: widget.index,
            modNum: widget.modNum,
            pages: title,
            
          ),
        ),
      );
    });
     return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              strokeWidth: 5,
              value: null,
              valueColor: new AlwaysStoppedAnimation(Colors.green),
            ),
            SizedBox(
              height: 10,
            ),
            Material(
              color: Colors.transparent,
              child: Text(
                "Loading... Please Wait !",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<List<Page>> getEventsFromFirestore(int modNum) async {
    print("hello");
    List<Page> title = [];

    await Firestore.instance
        .collection("activity")
        .where("module", isEqualTo: modNum)
        .getDocuments()
        .then((document) {
      document.documents.forEach((value) {
        print("fileupload"+value["content"].toString());
        words.clear();
        meanings.clear();
        for (String i in value["content"]) {
          print(i);
          words.add(i);
        }
        for (String i in value["Page"]) {
          meanings.add(i);
        }

       
      });
    });
   for (var i = 0; i < words.length; i++) {

            title.add(new Page(headding: meanings[i],body: words[i]));
          
        }
    return title;
  }

 

}
