import 'package:flutter/foundation.dart';

class NotificationModel{
  dynamic msg;
  dynamic timestamp;
  dynamic type;
  dynamic userId;

  NotificationModel({this.msg,this.timestamp,this.type,this.userId});

  factory NotificationModel.fromJson(Map<String,dynamic> json)=>
  NotificationModel(
    msg: json['msg'],
    timestamp: json['timestamp'],
    type: json['type'],
    userId: json['userId'],
  );
  Map<String,dynamic> toJson() => {
    "msg":this.msg,
    "timestamp":this.timestamp,
    "type":this.type,
    "userId":this.userId,
  };
}