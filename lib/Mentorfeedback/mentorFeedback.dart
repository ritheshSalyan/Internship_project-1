import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:startupreneur/models/mentorFeedbackModel.dart';

class MentorFeedback extends StatefulWidget {
  MentorFeedback({Key key, this.uid}) : super(key: key);
  String uid;
  @override
  _MentorFeedbackState createState() => _MentorFeedbackState();
}

class _MentorFeedbackState extends State<MentorFeedback> {
  List<MentorFeedbackModel> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Evaluation and Feedback"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("mentorFeedbackLMS")
            .where("userId", isEqualTo: widget.uid)
            .orderBy("timestamp", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          print(widget.uid);
          if (snapshot.hasData) {
            list.clear();
            snapshot.data.documents.forEach((data) {
              list.add(MentorFeedbackModel(
                message: data.data["message"],
                timeStamp: data.data["timestamp"],
                userId: data.data["userId"],
                uniqueId: data.data["uniqueId"],
                read: data.data["read"],
                moduleNumber: data.data["moduleNumber"],
              ));
            });
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DateTime date = new DateTime.fromMillisecondsSinceEpoch(
                    list[index].timeStamp*1000);
                var format = new DateFormat("d/M/y");
                var dateString = format.format(date);
                if (!list[index].read) {
                  Map<String, dynamic> data = Map<String, dynamic>();
                  data["message"] = list[index].message;
                  data["timestamp"] = list[index].timeStamp;
                  data["uniqueId"] = list[index].uniqueId;
                  data["userId"] = list[index].userId;
                  data["read"] = true;
                  data["moduleNumber"] = list[index].moduleNumber;
                  print(!list[index].read);
                  final DocumentSnapshot userDoc =
                      snapshot.data.documents[index];
                  print(userDoc.documentID);
                  Firestore.instance
                      .collection("mentorFeedbackLMS")
                      .document(userDoc.documentID)
                      .setData(data, merge: true);
                }
                return Card(
                  elevation: 5,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.001,
                          right: MediaQuery.of(context).size.width * 0.001,
                        ),
                        title: AutoSizeText(
                          "${list[index].message}",
                          maxLines: 10,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ActionChip(
                              backgroundColor: Colors.green,
                              label: Text(
                                '${list[index].moduleNumber}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ActionChip(
                              backgroundColor: Colors.green,
                              label: Text(
                                "$dateString",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  // Future<void> sendData(int index, dynamic userDoc) async {
  //   final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
  //       functionName: "modifyRead",
  //       parameters: <String, dynamic>{
  //         'message': list[index].message,
  //         'timestamp': list[index].timeStamp,
  //         'uniqueId': list[index].uniqueId,
  //         'userId': list[index].userId,
  //         'moduleNumber': list[index].moduleNumber,
  //         'id': userDoc.documentID,
  //       });
  //   await callable.call();
  // }
}
