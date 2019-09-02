import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class EmailVerification extends StatefulWidget {
  EmailVerification({Key key,this.user,this.status}):super(key:key);
  FirebaseUser user;
  bool status;
  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    verify(widget.user);
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("Verification Mail has been sent. Please Verify Your Mail"),
            ),
            OutlineButton( 
              child: Text("Resend Verification Mail"),
              onPressed: () async{
                 await widget.user.sendEmailVerification();
              },
            ),
             OutlineButton( 
              child: Text("Sign In"),
              onPressed: () async{
                // await widget.user.sendEmailVerification();
              },
            )
          ],
        )
      ),
      
    );
  }

  void verify(FirebaseUser user) async{
      user = await FirebaseAuth.instance.signInWithEmailAndPassword()
      print("******************User here:"+user.toString());
      if(user.isEmailVerified){
          print("User Verified");
      }
  }
}