// import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase/firebase.dart' as fb;
// import 'package:firebase/firestore.dart' as fs;
// import 'package:firebase/firebase.dart';

// class EmailVerification extends StatefulWidget {
//   EmailVerification({Key key, this.user, this.status}) : super(key: key);
//   var user;
//   bool status;
//   @override
//   _EmailVerificationState createState() => _EmailVerificationState();
// }

// class _EmailVerificationState extends State<EmailVerification> {
//   Auth auth;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     auth = fb.auth();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // verify(widget.user);
//     // print("object");
//     return Scaffold(
//       appBar: AppBar(title: Text("Login Screen")),
//       body: Center(
//         child: StreamBuilder(
//             stream: auth.currentUser.stream(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
//               // print("********************" + snapshot.toString());
//               if (!snapshot.hasData) {
//                 return Text("You are not logged In");
//               }
//               return Column(
//                 children: <Widget>[
//                   Text(
//                       "Logged in \n \n Email: ${snapshot.data.isEmailVerified}"),
//                   OutlineButton(
//                     child: Text("Reload"),
//                     onPressed: () async {
//                       FirebaseUser user =
//                           await FirebaseAuth.instance.currentUser();
//                       await user.reload();
//                       user = await FirebaseAuth.instance.currentUser();
//                       print(
//                           "*********************************************************${user.toString()}");
//                     },
//                   )
//                 ],
//               );
//             }),
//       ),
//     );
//   }

//   // void verify(FirebaseUser user) async{
//   //     user = await FirebaseAuth.instance.signInWithEmailAndPassword()
//   //     print("******************User here:"+user.toString());
//   //     if(user.isEmailVerified){
//   //         print("User Verified");
//   //     }
//   // }
// }
