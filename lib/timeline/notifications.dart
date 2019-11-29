import 'package:flutter/material.dart';
import 'package:startupreneur/globalKeys.dart';
import 'package:startupreneur/models/notificationModel.dart';

class NotificationDetail extends StatefulWidget {
  List<NotificationModel> listData;
  NotificationDetail({Key key, this.listData}) : super(key: key);
  @override
  _NotificationDetailState createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Global.date = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification Center",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: (widget.listData.length != 0)
          ? ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: widget.listData.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 8,
                  child: ListTile(
                    title: Text("${widget.listData[index].msg}"),
                    subtitle: Text("${widget.listData[index].type}"),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                "No new notifications",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
    );
  }
}
