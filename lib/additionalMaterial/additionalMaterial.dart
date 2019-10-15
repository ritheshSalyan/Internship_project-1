import 'dart:io';
import 'package:archive/archive.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/models/additionalMaterial.dart';
import 'package:toast/toast.dart';

import '../OfflineBuilderWidget.dart';

class AdditionalMaterialPage extends StatefulWidget {
  @override
  _AdditionalMaterialPageState createState() => _AdditionalMaterialPageState();
}

class _AdditionalMaterialPageState extends State<AdditionalMaterialPage> {
  List<AdditionalMaterial> list = [];
  bool state = false;
  File file;
  var directory = '/storage/emulated/0/Startupreneur/AdditionalMaterial/';

  Future<void> unarchiveAndSave(var zippedFile, var dir) async {
    try {
      var bytes = zippedFile.readAsBytesSync();
      var archive = ZipDecoder().decodeBytes(bytes);
      for (var file in archive) {
        var fileName = '$dir/${file.name}';
        if (file.isFile) {
          print("file $file");
          var outFile = File(fileName);
          outFile = await outFile.create(recursive: true);
          outFile.writeAsBytesSync(file.content);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<File> downloadFile(
      String modName, String filePath, String fileName) async {
    final dir = await getTemporaryDirectory();
    print(dir.path);
    print(fileName);

    await Directory('/storage/emulated/0/Startupreneur').exists().then((yes) {
      if (!yes) {
        print("inside failed loop $yes");
        Directory('/storage/emulated/0/Startupreneur').create();
      } else {
        print("im here");
        Directory(
                '/storage/emulated/0/Startupreneur/AdditionalMaterial/$modName/')
            .create();
      }
    }).catchError((e) {
      Directory(
              '/storage/emulated/0/Startupreneur/AdditionalMaterial/$modName/')
          .create();
    });
    try {
      await FlutterDownloader.enqueue(
        url: filePath,
        savedDir:
            '/storage/emulated/0/Startupreneur/AdditionalMaterial/$modName/',
        fileName: fileName,
        showNotification: true,
        openFileFromNotification: true,
      );
      FlutterDownloader.registerCallback((id, status, progress) {
        print(progress);
      });
      return File('/storage/emulated/0/Startupreneur/AdditionalMaterial/$modName/$fileName');
    } catch (e) {
      print(e);
      Toast.show("$e", context, gravity: Toast.BOTTOM, duration: 5);
    }
  }

  Widget fileName(int index, String file, String modName) {
    String uri = Uri.decodeFull(file);
    final RegExp regex =
        RegExp('([^?/]*\.(pdf|jpg|txt|docx|zip|jpeg|png|csv))');
    String fileName = regex.stringMatch(uri);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        AutoSizeText(
          fileName.split('.')[0],
          style: TextStyle(
            color: Colors.green,
          ),
          overflow: TextOverflow.ellipsis,
          maxFontSize: 14,
          maxLines: 1,
        ),
        IconButton(
          icon: Icon(Icons.file_download),
          onPressed: () async {
            await downloadFile(modName, file, fileName).then((data) {
              print(" the file is  $data");
              unarchiveAndSave(data,
                  '/storage/emulated/0/Startupreneur/AdditionalMaterial/$modName');
            });
          },
        )
      ],
    );
  }

  final expansinIconClose = Icon(Icons.arrow_drop_down);
  final expansinIconOpen = Icon(Icons.arrow_drop_up);

  @override
  Widget build(BuildContext context) {
    return CustomeOffline(
      onConnetivity: Scaffold(
        appBar: AppBar(
          title: Text("Additional Materials"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              Firestore.instance.collection("additionalMaterial").snapshots(),
          builder: (context, snapshot) {
            list.clear();

            if (snapshot.hasData) {
              snapshot.data.documents.forEach((data) {
                list.add(
                  AdditionalMaterial.fromJson(data.data),
                );
              });
              return ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.01,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ExpansionTile(
                      trailing: (!state) ? expansinIconClose : expansinIconOpen,
                      onExpansionChanged: (value) {
                        if (value) {
                          print(value);
                          setState(() {
                            state = true;
                          });
                        } else {
                          print(value);
                          setState(() {
                            state = false;
                          });
                        }
                      },
                      title: Text(list[index].name),
                      children: <Widget>[
                        ListTile(
                          title: fileName(
                              index, list[index].file, list[index].name),
                          subtitle: AutoSizeText(
                            list[index].description,
                            style: TextStyle(),
                            maxFontSize: 12,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
            return Center(
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
                      "Loading... Please Wait",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
