import 'CommentsAdd.dart';

class ChatBoardData {
  String uid;
  String question;
  String tag;
  dynamic upvote;
  List<dynamic> upvoters;
  dynamic timestamp;
  dynamic uniqId;
  dynamic profileUrl;
  dynamic userName;

  ChatBoardData({
    this.uid,
    this.question,
    this.tag,
    this.upvote,
    this.upvoters,
    this.timestamp,
    this.uniqId,
    this.profileUrl,
    this.userName,
  });

  factory ChatBoardData.fromJson(Map<String, dynamic> json) {
    print(json);
    return ChatBoardData(
      uid: json['uid'] == null ? null : json["uid"],
      question: json['question'] == null ? null : json['question'],
      tag: json['tag'] == null ? null : json['tag'],
      upvote: json['upvote'] == null ? null : json['upvote'],
      upvoters: json['upvoters'] == null
          ? null
          : List<dynamic>.from(json['upvoters'].map((x) => x)),
      timestamp: json['timestamp'] == null ? null : json['timestamp'],
      uniqId: json['uniqId'] == null ? null : json['uniqId'],
      profileUrl: json["profileUrl"] == null ? null : json["profileUrl"],
      userName: json["userName"] == null ? null : json["userName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": this.uid == null ? null : this.uid,
        "question": this.question == null ? null : this.question,
        "uniqId": this.uniqId == null ? null : this.uniqId,
        "tag": this.tag == null ? null : this.tag,
        "upvote": this.upvote == null ? null : this.upvote,
        "upvoters": this.upvoters == null
            ? []
            : List<dynamic>.from(this.upvoters.map((x) => x)),
        "timestamp": this.timestamp == null ? 0 : this.timestamp,
        "profileUrl": this.profileUrl == null ? null : this.profileUrl,
        "userName": this.userName == null ? null : this.userName,
      };
}
