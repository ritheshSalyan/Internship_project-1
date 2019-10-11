class CommentsAdd{
  String uid;
  String comments;
  dynamic timestamp;
  dynamic questionId;
  dynamic profile;
  dynamic userName;


  CommentsAdd({this.uid,this.comments,this.timestamp,this.questionId,this.profile,this.userName,});

  factory CommentsAdd.fromJson(Map<String,dynamic> json){
    print(json);
   return  CommentsAdd(
    uid: json['uid']==null?null:json['uid'],
    comments: json['comments']==null?null:json['comments'],
    timestamp: json['timestamp']==null?null:json['timestamp'],
    questionId: json['questionId']==null?null:json['questionId'],
    profile:json['profile']==null?null:json['profile'],
    userName: json['userName']==null?null:json['userName'],
  );
  }

  

  Map<String,dynamic> toJson()=>{
    'uid':this.uid==null?null:this.uid,
    'comments':this.comments==null?null:this.comments,
    'timestamp':this.timestamp==null?null:this.timestamp,
    'questionId':this.questionId==null?null:this.questionId,
    'profile':this.profile==null?null:this.profile,
    'userName':this.userName==null?null:this.userName,
  };
}