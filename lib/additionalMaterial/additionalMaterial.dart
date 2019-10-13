import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/models/additionalMaterial.dart';

class AdditionalMaterialPage extends StatefulWidget {
  @override
  _AdditionalMaterialPageState createState() => _AdditionalMaterialPageState();
}

class _AdditionalMaterialPageState extends State<AdditionalMaterialPage> {
  List<AdditionalMaterial> list = [];

  Widget fileName(int index, String file) {
    String uri = Uri.decodeFull(file);
    final RegExp regex = RegExp('([^?/]*\.(pdf|jpg|txt|docx))');
    String fileName = regex.stringMatch(uri);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          fileName,
          style: TextStyle(
            color: Colors.green,
            fontSize: 14,
            letterSpacing: 1.1,
          ),
        ),
        IconButton(
          icon: Icon(Icons.file_download),
          onPressed: () {},
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomeOffline(
      onConnetivity: Scaffold(
        appBar: AppBar(
          title: Text("Additional Material"),
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
                      title: Text(list[index].name),
                      children: <Widget>[
                        ListTile(
                          title: fileName(index, list[index].file),
                          subtitle: Text(
                            list[index].description,
                            style: TextStyle(
                              fontSize: 12,
                            ),
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
