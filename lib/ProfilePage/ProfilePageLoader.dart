import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ProfilePage/frienddetails/friend_details_page.dart';
import 'friends/friend.dart';
// import '../../ModuleOrderController/Types.dart';

class ProfileLoading extends StatefulWidget {
  ProfileLoading({Key key,this.uid}) : super(key: key);
  String uid;
  
  // final int modNum;
  @override
  _ProfileLoading createState() => _ProfileLoading();
}

class _ProfileLoading extends State<ProfileLoading> {
    String uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.uid).then((title){
      print("Title is "+title.points.toString());
         Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => FriendDetailsPage(friend: title),
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
  static String avatar;

  static Future<Friend> getEventsFromFirestore(String uid) async {
    // FirebaseAuth.instance.currentUser().then((user){
      
    //   this.uid = user.uid;
    // });
    // print
      CollectionReference ref = Firestore.instance.collection('user');
QuerySnapshot eventsQuery = await ref
    .where("uid", isEqualTo: uid)
    .getDocuments();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
Friend title;

eventsQuery.documents.forEach((document) {
  print("Profile "+document.data["profile"].toString());
  try{ 
   avatar = document.data["profile"].toString();
   if(avatar == "null"){
    avatar =  "https://firebasestorage.googleapis.com/v0/b/thestartupreneur-e1201.appspot.com/o/images%2Favatar.png?alt=media&token=d6c06033-ba6d-40f9-992c-b97df1899102";

   }
   }catch(e){
     print("inside catch ");
    avatar =  "https://firebasestorage.googleapis.com/v0/b/thestartupreneur-e1201.appspot.com/o/images%2Favatar.png?alt=media&token=d6c06033-ba6d-40f9-992c-b97df1899102";

   }
   print("points is = "+document.data.toString());
  title = new Friend(
    name: document.data["name"].toString(),
    mobile: document.data["mobile"].toString(),
    occupation: document.data["typeOfOccupations"].toString(),
    institution: document.data["institutionOrCompany"].toString(),
    points: document.data["points"],
    email: document.data["email"].toString(),
    completed: document.data["completed"],
    gender: document.data["gender"].toString(),
   avatar: avatar,
    uid:document.data["uid"].toString(),
  );
  // for (var item in document["Profile" ]) {
  //    //title.add(item.toString());
  // }
 
  
});
  return title;
  }
}
