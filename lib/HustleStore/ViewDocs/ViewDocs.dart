import 'dart:io';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:permission/permission.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:startupreneur/Auth/PdfReader.dart';
import 'package:startupreneur/progress_dialog/progress_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';

class ViewDocs extends StatefulWidget {

  ViewDocs({Key key, this.lengthList, this.doc}) : super(key: key);
  dynamic lengthList;
  List<dynamic> doc;

  @override
  _ViewDocsState createState() => _ViewDocsState();


}



class _ViewDocsState extends State<ViewDocs> {
  String fileName;
  ProgressDialog progressDialog;
  File file;
  PDFDocument document;

  
    @override
    void initState(){
      request();
      Analytics.analyticsBehaviour("View_Docs_Page_Hustle", "ViewDocs");
    }
    
    request() async{
      await Permission.requestPermissions([PermissionName.Storage]);
    }

  

  String fileNameRetriver(int index) {
    String uri = Uri.decodeFull(widget.doc[index]);
    final RegExp regex = RegExp('([^?/]*\.(pdf))');
    String file = regex.stringMatch(uri);
    return file;
  }


 void downloadFile(int index,BuildContext context) async {



    progressDialog = ProgressDialog(context, ProgressDialogType.Normal);
    // Directory('/storage/emulated/0/Startupreneur/cache').exists().then((yes) {
    //   if (!yes) {
    //     print("inside failed loop $yes");
    //     Directory('/storage/emulated/0/Startupreneur/cache').create();
    //   }
    // }).catchError((e) {
    //   Directory('/storage/emulated/0/Startupreneur/cache').create();
    // });
    String uri = Uri.decodeFull(widget.doc[index]);
    final RegExp regex = RegExp('([^?/]*\.(pdf))');
    String fileName = regex.stringMatch(uri);
    // final dir = ('/storage/emulated/0/Startupreneur/cache');
    final dir = ((await getExternalStorageDirectory()).path);

    print("File path $dir");
    file = File('$dir/$fileName');
    print("from download $fileName");
    int size = await file.length();
    print("Curent directory $size");


    progressDialog.setMessage("Opening file  ...");
    progressDialog.show();
    HttpClient client = new HttpClient();
    await client
        .getUrl(Uri.parse(widget.doc[index]))
        .then((HttpClientRequest request) {
      print("nop");
      return request.close();
    }).then((HttpClientResponse response) {
      print("writing");
      response.pipe((file).openWrite());
      print("done");
      progressDialog.hide();
      // Toast.show("Check the file in your Internal Storage in the folder Startupreneur/cache/$fileName in storage", context,
          // gravity: Toast.BOTTOM, duration: 5);
    }).catchError((e) {
      print("error $e");
      progressDialog.hide();
      Toast.show("Error downloading ...$e", context,
          gravity: Toast.BOTTOM,
          duration: 5,
          backgroundColor: Colors.red,
          textColor: Colors.black);
    });
    try{
    
      document = await PDFDocument.fromAsset("assets/pdf/t_and_c.pdf");
    }catch(e){
      print(e);
    }
    File("${dir}/$fileName").exists().then((res){
      if(res){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context)=>PdfReader(document,"View Documents"),
            fullscreenDialog: true
          )
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width * 0.9;
    final double height = MediaQuery.of(context).size.height * 0.75;
    Widget child;
    return Scaffold(
      appBar: AppBar(
        title: Text("View Documents"),
      ),
      body: OfflineBuilder(
        connectivityBuilder:
            (context, ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            child = GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: width / height,
              ),
              itemCount: widget.lengthList,
              itemBuilder: (context, int index) {
                fileName = fileNameRetriver(index);
                return GestureDetector(
                  onTap: (){
                    downloadFile(index,context);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  elevation: 5.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Card(
                        child: Image.asset(
                          "assets/Images/pdf.png",
                        ),
                      ),
                      Container(
                        color: Colors.green,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.32,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text(
                                "$fileName",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            // SizedBox(width: 40),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                );
              },
            );
          }
          return (child);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'There are no bottons to push :)',
            ),
            new Text(
              'Just turn off your internet.',
            ),
          ],
        ),
      ),
    );
  }
}
