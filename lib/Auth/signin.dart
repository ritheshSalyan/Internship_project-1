import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupreneur/IntroPage/intropage.dart';
import 'package:startupreneur/home.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  static final _formkey = GlobalKey<FormState>();
  static final _popupformkey = GlobalKey<FormState>();

  static String _email = "";
  static String _password = "";
  static String _otpEmail = "";

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

  static validateAndSubmit() async {
    if (_validate()) {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => new introPage()));
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
      labelStyle: TextStyle(color:Colors.white,fontSize: 12),
      hintStyle: TextStyle(fontSize: 12),
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
      labelStyle: TextStyle(color:Colors.white,fontSize: 12),
      hintStyle: TextStyle(fontSize: 12),
    ),
  );

  Widget loginButton(BuildContext context) => ButtonTheme(
        minWidth: 300,
        height: 50,
        // buttonColor: Color(0xffffffff),
        child: RaisedButton(
          elevation: 5,
          color: Colors.green,
          // color: Color.fromRGBO(129, 199, 132, 1),
          onPressed: () {
            validateAndSubmit();
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => new introPage(),
            //   ),
           // );
          },
          child: Text(
            "Login",
            style: TextStyle( fontSize: 12),
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
              icon: Icon(Icons.arrow_back),
              onPressed: (){
               Navigator.of(context).pop(
                 MaterialPageRoute(builder: (context)=>homePage())
               );
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
                    fontSize: 20,
                    letterSpacing: 2,
                    fontFamily: "Open Sans"
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 200),
                ),
                Text(
                  "           ",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.green,
                    decorationThickness: 5
                  ),
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
                            title: Text("Forget Password" ,),
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
                    style: TextStyle( fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                loginButton(context)
              ],
            ),
          ),
        ))
        );
  }
}
