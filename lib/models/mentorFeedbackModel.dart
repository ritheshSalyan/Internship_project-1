class MentorFeedbackModel {
  String message;
  dynamic moduleNumber;
  dynamic timeStamp;
  String uniqueId;
  String userId;
  bool read;

  MentorFeedbackModel({
    this.message,
    this.moduleNumber,
    this.read,
    this.uniqueId,
    this.timeStamp,
    this.userId,
  });

  factory MentorFeedbackModel.fromJson(Map<String, dynamic> json) =>
      MentorFeedbackModel(
        message: json['message'] == null ? null : json['message'],
        moduleNumber:
            json['moduleNumber'] == null ? null : json['moduleNumber'],
        timeStamp: json['timestamp'] == null ? null : json['timestamp'],
        uniqueId: json['unqiueId'] == null ? null : json['uniqueId'],
        userId: json['userId'] == null ? null : json['userId'],
        read: json['read'] == null ? null : json['read'],
      );

  Map<String, dynamic> toJson() => {
        "message": this.message == null ? null : this.message,
        "moduleNumber": this.moduleNumber == null ? null : this.moduleNumber,
        "timestamp": this.timeStamp == null ? null : this.timeStamp,
        "unqiueId": this.uniqueId == null ? null : this.uniqueId,
        "userId": this.userId = null ? null : this.userId,
        "read": this.read == null ? null : true
      };
}
