import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupreneur/timeline/trial.dart';
import 'package:startupreneur/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:startupreneur/progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  static final _formkey = GlobalKey<FormState>();
  static final _popupformkey = GlobalKey<FormState>();
  static ProgressDialog progressDialog;

  static String _email = "";
  static String _password = "";
  static String _otpEmail = "";
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static SharedPreferences sharedPreferences;

  static preferences(String userId,String _email) async {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("UserId", userId);
      sharedPreferences.setString("UserEmail",_email );
      print(sharedPreferences.getString("UserId"));
  }

  static void signUpInwithEmail(BuildContext context) async {
    FirebaseUser user;
    progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
    progressDialog.setMessage("Signing in ..");
    try {
      progressDialog.show();
      user = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      preferences(user.uid,_email);
      progressDialog.hide();
      print("Sign in Successfull");
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>new TimelinePage(title: "Time line",userEmail: _email),)
      );
    } catch (e) {
      // print(e.toString());
      progressDialog.hide();
     Toast.show(
       "Email or password does not match",
       context,
       gravity:Toast.BOTTOM,
       duration: Toast.LENGTH_LONG
     );
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

  static otpValidation() async {
    if (_otpvalidate()) {
      print("$_otpEmail");
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

  static validateAndSubmit(BuildContext context) async {
    if (_validate()) {
      signUpInwithEmail(context);
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (context) => new introPage()));
    }
  }

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
      labelText: "Email address",
      labelStyle: TextStyle(color: Colors.black, fontSize: 12),
      hintStyle: TextStyle(fontSize: 12,color: Colors.black),
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
      hintText: "Passowrd",
      labelText: "Password",
      labelStyle: TextStyle(color: Colors.black, fontSize: 12),
      hintStyle: TextStyle(fontSize: 12,color: Colors.black),
    ),
  );

  Widget loginButton(BuildContext context) => ButtonTheme(
        minWidth: 300,
        height: 50,
        // buttonColor: Color(0xffffffff),
        child: RaisedButton(
          elevation: 5,
          color: Colors.green,        
          onPressed: (){
            validateAndSubmit(context);
          },
          child: Text(
            "Login",
            style: TextStyle(fontSize: 12),
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
        // // backgroundColor: Color.fromRGBO(52, 52, 52, 1),
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
        body: Center(
            child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: ListView(
              children: <Widget>[
                Text(
                  "SIGN IN",
                  style: TextStyle(
                      fontSize: 20, letterSpacing: 2, fontFamily: "Open Sans"),
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
                            backgroundColor: Color.fromRGBO(52, 52, 52, 1),
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
                                              validator: (value) =>
                                                  value.isEmpty
                                                      ? "Email cannot be empty"
                                                      : null,
                                              onSaved: (value) =>
                                                  _otpEmail = value,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.email,
                                                      color: Colors.black),
                                                  hintText:
                                                      "Enter email address",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12),
                                                  labelText: "Email Address",
                                                  labelStyle: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 12),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(10),
                                                      borderSide: BorderSide(
                                                          color: Colors.green,
                                                          width: 2.0)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .green))),
                                            ),
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: ButtonTheme(
                                            minWidth: 300,
                                            height: 50,
                                            buttonColor: Color(0xffffffff),
                                            child: OutlineButton(
                                                onPressed: otpValidation,
                                                child: Text(
                                                  "Send OTP",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 12),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
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
                    "Forgot password ?",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                loginButton(context)
              ],
            ),
          ),
        )));
  }
}
