// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:startupreneur/NoInternetPage/NoNetPage.dart';
import 'package:startupreneur/timeline/MainRoadmapLoader.dart';
import 'package:startupreneur/home.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:startupreneur/progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'fire';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  static final _formkey = GlobalKey<FormState>();
  static final _popupformkey = GlobalKey<FormState>();
  static ProgressDialog progressDialog;
  FirebaseMessaging _messaging = FirebaseMessaging();
  static String _email = "";
  static String _password = "";
  static String _otpEmail = "";
  static String tokenId = "";
  // static final FirebaseAuth _auth = FirebaseAuth.instance;
  static SharedPreferences sharedPreferences;
  // static Firestore db = Firestore.instance;
  static Auth auth;
  static fs.Firestore firestore = fb.firestore();

  @override
  void initState() {
    super.initState();
    // _messaging.getToken().then((token) {
    //   setState(() {
    //     tokenId = token;
    //   });
    // });
    auth = fb.auth();
    print("inside login init");
    // fb.Analytics.getInstance().analyticsBehaviour("Sign_in_page", "SignIn");
  }

  static preferences(String userId, String _email, String docId) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("UserId", userId);
    sharedPreferences.setString("UserEmail", _email);
    sharedPreferences.setString("docId", docId);

    // Analytics.setUserId(userId);
    // print(sharedPreferences.getString("UserId"));
    // var data = Map<String, dynamic>();
    // data["mobToken"] = tokenId;
    // await firestore.collection("pushToken").doc(userId).set(data);
  }

  void signUpInwithEmail(BuildContext context) async {
    // FirebaseUser user;
    progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
    progressDialog.setMessage("Signing in ..");
    try {
      progressDialog.show();
      // print("Helloo woorld");
      await firestore
          .collection("user")
          .where("email", "==", _email)
          .get()
          .then((document) {
        document.docs.forEach((data) async {
          var id = data.data();
          var isLoggedIn = id['isLoggedIn'];
          if (isLoggedIn) {
            print("IsLoged in true");
            Toast.show(
                "Email is already logged in , please logout from other device",
                context,
                gravity: Toast.BOTTOM,
                duration: Toast.LENGTH_LONG);
            progressDialog.hide();
          } else {
            print("IsLoged in false");

            var user = await auth.signInWithEmailAndPassword(
              _email,
              _password,
            );
             firestore.collection("user").doc(user.user.uid).set({
              "isLoggedIn": false,
            }, fs.SetOptions(merge: true));
            print(user.user.uid);
            print(_email);
            print(data.id);
            preferences(user.user.uid, _email, data.id);
            progressDialog.hide();
            print("Sign in Successfull");
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => new RoadmapLoader(),
            ));
          }
        });
      });
    } catch (e) {
      print(e.toString());
      progressDialog.hide();
      // Toast.show("Email or password does not match", context,
      //     gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
    }
  }

  static bool _otpvalidate() {
    final otpform = _popupformkey.currentState;

    if (otpform.validate()) {
      otpform.save();
      return true;
    }
    return false;
  }

  static otpValidation(BuildContext context) async {
    if (_otpvalidate()) {
      // print("$_otpEmail");
      Toast.show("Password Reset Mail has been sent", context,
          duration: Toast.LENGTH_LONG);
      Navigator.of(context).pop();
      await auth.sendPasswordResetEmail(_otpEmail);
    }
  }

  static bool _validate() {
    final form = _formkey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  validateAndSubmit(BuildContext context) async {
    if (_validate()) {
      signUpInwithEmail(context);
//       Navigator.of(context)
//           .pushReplacement(MaterialPageRoute(builder: (context) => new introPage()));
    }
  }

  Widget createAccountLink(BuildContext context) => OutlineButton(
        borderSide: BorderSide(
          color: Colors.green,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SignupPage(),
          ));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text("New User? Register",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
      );

  final emailField = TextFormField(
    keyboardType: TextInputType.emailAddress,
    obscureText: false,
    validator: (value) {
      if (value.isEmpty) {
        return "Email field cannot be empty";
      }
      return null;
    },
    onSaved: (value) {
      _email = value;
    },
    decoration: InputDecoration(
      prefixIcon: Icon(
        Icons.email,
        color: Colors.green,
      ),
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(10),
      //   borderSide: BorderSide(color: Colors.green, width: 2.0),
      // ),
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(10),
      //   borderSide: BorderSide(color: Colors.green, width: 2.0),
      // ),
      hintText: "you@example.com",
      labelText: "Email Address",
      labelStyle:
          TextStyle(color: Colors.black, fontSize: 12, letterSpacing: 0.5),
      hintStyle:
          TextStyle(fontSize: 12, color: Colors.black, letterSpacing: 0.5),
    ),
  );

  final passwordField = TextFormField(
    obscureText: true,
    validator: (value) {
      if (value.isEmpty) {
        return "password cannot be empty";
      } else if (value.length < 8) {
        return "password must be atleast 8 digits";
      }
      return null;
    },
    onSaved: (value) {
      _password = value;
    },
    decoration: InputDecoration(
      prefixIcon: Icon(
        Icons.lock,
        color: Colors.green,
      ),
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(10),
      //   borderSide: BorderSide(color: Colors.green, width: 2.0),
      // ),
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(10),
      //   borderSide: BorderSide(color: Colors.green, width: 2.0),
      // ),
      hintText: "Password",
      labelText: "Password",
      labelStyle:
          TextStyle(color: Colors.black, fontSize: 12, letterSpacing: 0.5),
      hintStyle:
          TextStyle(fontSize: 12, color: Colors.black, letterSpacing: 0.5),
    ),
  );

  Widget loginButton(BuildContext context) => ButtonTheme(
        minWidth: 300,
        height: 50,
        // buttonColor: Color(0xffffffff),
        child: RaisedButton(
          elevation: 5,
          color: Colors.green,
          onPressed: () {
            validateAndSubmit(context);
          },
          child: Text(
            "Login",
            style: TextStyle(letterSpacing: 0.5),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          // borderSide: BorderSide(
          //   width: 1.5,
          //   color: Colors.green,
          //   style: BorderStyle.solid,
          // ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 245, 252, 1),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .pop(MaterialPageRoute(builder: (context) => homePage()));
          },
        ),
        toolbarOpacity: 1,
        backgroundColor: Theme.of(context).primaryColorDark,
        automaticallyImplyLeading: false,
      ),
      // body:
      body: Center(
        child: Card(
          child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.4,
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formkey,
              child: ListView(
                children: <Widget>[
                  Text(
                    "SIGN IN",
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                        fontFamily: "Open Sans"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 200),
                  ),
                  Text(
                    "           ",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.green,
                        decorationThickness: 5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                  ),
                  emailField,
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  passwordField,
                  FlatButton(
                    padding: EdgeInsets.only(left: 70),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text(
                                "Forget Password",
                              ),
                              content: Form(
                                  key: _popupformkey,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Container(
                                              child: TextFormField(
                                                validator: (value) => value
                                                        .isEmpty
                                                    ? "Email cannot be empty"
                                                    : null,
                                                onSaved: (value) =>
                                                    _otpEmail = value,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                    prefixIcon: Icon(
                                                        Icons.email,
                                                        color: Colors.green),
                                                    hintText:
                                                        "Enter email address",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                    labelText: "Email Address",
                                                    labelStyle: TextStyle(
                                                        color: Colors.green,
                                                        letterSpacing: 0.5,
                                                        fontSize: 12),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color: Colors.green,
                                                            width: 2.0)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.green))),
                                              ),
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(top: 20),
                                            child: ButtonTheme(
                                              minWidth: 300,
                                              height: 50,
                                              buttonColor: Color(0xffffffff),
                                              child: OutlineButton(
                                                  onPressed: () {
                                                    otpValidation(context);
                                                  },
                                                  child: Text(
                                                    "Send Email",
                                                    style: TextStyle(
                                                        letterSpacing: 0.5,
                                                        color: Colors.green,
                                                        fontSize: 12),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  borderSide: BorderSide(
                                                      color: Colors.green,
                                                      width: 2.0)),
                                            ))
                                      ],
                                    ),
                                  )),
                            );
                          });
                    },
                    child: Text(
                      "Forgot Password ?",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 12, letterSpacing: 0.5),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  loginButton(context),
                  SizedBox(
                    height: 20,
                  ),
                  // createAccountLink(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
