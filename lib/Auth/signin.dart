import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  static final _formkey = GlobalKey<FormState>();

  static String _email = "";
  static String _password = "";


  static bool _validate() {
    final form = _formkey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  static validateAndSubmit() async {

    if(_validate()){
      print("hello");
      print("$_email");
      print("$_password");
    }
  }


  final emailField = TextFormField(
    keyboardType: TextInputType.emailAddress,
    obscureText: false,
    validator: (value){
      if(value.isEmpty){
        return "Email field cannot be empty";
      }
      return null;
    },
    onSaved: (value){
      _email = value;
    },
    decoration: InputDecoration(
      prefixIcon: Icon(
        Icons.email,
        color: Colors.grey,
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green, width: 2.0)),
      hintText: "you@example.com",
      labelText: "Email address",
      labelStyle: TextStyle(color: Colors.green),
      hintStyle: TextStyle(color: Colors.black),
    ),
  );

  final passwordField = TextFormField(
    obscureText: true,
    validator: (value){
      if(value.isEmpty){
        return "password cannot be empty";
      }
      else if(value.length < 8){
        return "password must be atleast 8 digits";
      }
      return null;
    },
    onSaved: (value){
      _password = value;
    },
    decoration: InputDecoration(
      prefixIcon: Icon(
        Icons.lock,
        color: Colors.grey,
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green, width: 2.0)),
      hintText: "Passowrd",
      labelText: "Password",
      labelStyle: TextStyle(color: Colors.green),
      hintStyle: TextStyle(color: Colors.black),
    ),
  );

  final loginButton = ButtonTheme(
    minWidth: 300,
    height: 50,
    buttonColor: Color(0xffffffff),
    child: OutlineButton(
      onPressed: validateAndSubmit,
      child: Text("Login", style: TextStyle(color: Colors.black)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.green,
        style: BorderStyle.solid,
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Sign In",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.0,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.green),
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
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                    ),
                    emailField,
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    passwordField,
                    FlatButton(
                      padding: EdgeInsets.only(left: 70),
                      onPressed: () {},
                      child: Text(
                        "Forgot password ?",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    loginButton
                  ],
                ),
              ),
      )));
  }
}
